Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUF0NVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUF0NVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 09:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUF0NVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 09:21:42 -0400
Received: from mail1.kontent.de ([81.88.34.36]:52180 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262422AbUF0NVk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 09:21:40 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Rob Landley <rob@landley.net>
Subject: Re: Process in D state with USB and swsuspsp
Date: Sun, 27 Jun 2004 15:22:40 +0200
User-Agent: KMail/1.6.2
Cc: Brad Campbell <brad@wasp.net.au>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200406262031.14464.rob@landley.net> <40DE5BC0.7080206@wasp.net.au> <200406270350.46641.rob@landley.net>
In-Reply-To: <200406270350.46641.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406271522.40302.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Juni 2004 10:50 schrieb Rob Landley:
> It's just that a hot-pluggable bus, it should be possible to convince the 
> thing to reprobe all devices on a bus reset.  Oh well.

No, we cannot reprobe. How are we supposed to do that?
Probe() works only on new devices. Suspend/resume cycles must
leave driver bindings alone. All we could do is fail resume().
That however is not taken notice of in the driver core.

	Regards
		Oliver
