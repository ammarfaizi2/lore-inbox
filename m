Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVKANDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVKANDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKANDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:03:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38335 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750780AbVKANDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:03:39 -0500
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
From: David Woodhouse <dwmw2@infradead.org>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org
In-Reply-To: <200511011340.41266.duncan.sands@math.u-psud.fr>
References: <4363F9B5.6010907@free.fr>
	 <20051031155803.2e94069f.akpm@osdl.org>
	 <200511011340.41266.duncan.sands@math.u-psud.fr>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 13:04:02 +0000
Message-Id: <1130850242.21212.29.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 13:40 +0100, Duncan Sands wrote:
> this code looks like a 'orrible hack to work around a common problem
> with USB modem's of this type: if the modem is plugged in while the
> system boots, the driver may look for firmware before the filesystem
> holding the firmware is mounted; I guess the delay usually gives
> the filesystem enough time to be mounted.  I'm told that the correct
> solution is to stick the firmware in an initramfs as well. 

Why can't we request the firmware again when the device is first used,
if it wasn't present when the driver was first loaded?

-- 
dwmw2

