Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965885AbWKHOi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965885AbWKHOi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965819AbWKHOiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:38:25 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:10759 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965804AbWKHOhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:55 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 32/33] usb: usbmidi kill urb cleanup
Date: Wed, 8 Nov 2006 15:37:00 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611062228.38937.m.kozlowski@tuxland.pl> <200611071030.57152.m.kozlowski@tuxland.pl> <20061107013702.46b5710f.akpm@osdl.org>
In-Reply-To: <20061107013702.46b5710f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611081537.01905.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/sound/usb/usbmidi.c	2006-11-06 17:09:28.000000000 +0100
+++ linux-2.6.19-rc4/sound/usb/usbmidi.c	2006-11-07 17:08:32.000000000 +0100
@@ -981,7 +981,7 @@ void snd_usbmidi_disconnect(struct list_
 			if (umidi->usb_protocol_ops->finish_out_endpoint)
 				umidi->usb_protocol_ops->finish_out_endpoint(ep->out);
 		}
-		if (ep->in && ep->in->urb)
+		if (ep->in)
 			usb_kill_urb(ep->in->urb);
 	}
 }
