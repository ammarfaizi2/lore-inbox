Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264657AbUEJLhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264657AbUEJLhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264644AbUEJLfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:35:34 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:52356 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264653AbUEJLen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:34:43 -0400
Subject: Re: [PATCH] usblp.c (Was: usblp_write spins forever after an error)
From: David Woodhouse <dwmw2@infradead.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Greg KH <greg@kroah.com>, Andy Lutomirski <luto@myrealbox.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Oliver Neukum <oliver@neukum.org>
In-Reply-To: <4048C2E7.8050907@grupopie.com>
References: <402FEAD4.8020602@myrealbox.com>
	 <20040216035834.GA4089@kroah.com>  <4030DEC5.2060609@grupopie.com>
	 <1078399532.4619.129.camel@hades.cambridge.redhat.com>
	 <4047221E.9050500@grupopie.com>
	 <1078479692.12176.32.camel@imladris.demon.co.uk>
	 <40488E45.7070901@grupopie.com>  <4048C2E7.8050907@grupopie.com>
Content-Type: text/plain
Message-Id: <1084188865.21553.28.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1.dwmw2.1) 
Date: Mon, 10 May 2004 12:34:25 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-05 at 18:11 +0000, Paulo Marques wrote:
> Anyway, this time I tested it using blocking and non-blocking I/O and it works 
> for both cases. Even better, this patch only changes the behaviour for 
> non-blocking I/O, and keeps the same behaviour for the more usual blocking I/O 
> (at least on kernel 2.6).

I'm still seeing problems with an HP LaserJet 1200. 

May  7 07:12:56 imladris kernel: usb 1-1.3.2: new full speed USB device using address 10
May  7 07:12:56 imladris kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 10 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0317
May  8 20:26:12 imladris kernel: drivers/usb/class/usblp.c: usblp0: nonzero read/write bulk status received: -110
May  8 20:26:12 imladris kernel: drivers/usb/class/usblp.c: usblp0: failed reading printer status
May  8 20:26:12 imladris kernel: drivers/usb/class/usblp.c: usblp0: nonzero read/write bulk status received: -110
May  8 20:26:12 imladris kernel: drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
May  8 20:26:43 imladris last message repeated 10225 times
May  8 20:27:09 imladris last message repeated 8780 times

-- 
dwmw2


