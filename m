Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUCDLZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 06:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbUCDLZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 06:25:43 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:64919 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261827AbUCDLZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 06:25:42 -0500
Subject: Re: [linux-usb-devel] Re: [BUG] usblp_write spins forever after an
	error
From: David Woodhouse <dwmw2@infradead.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Greg KH <greg@kroah.com>, Andy Lutomirski <luto@myrealbox.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <4030DEC5.2060609@grupopie.com>
References: <402FEAD4.8020602@myrealbox.com>
	 <20040216035834.GA4089@kroah.com>  <4030DEC5.2060609@grupopie.com>
Content-Type: text/plain
Message-Id: <1078399532.4619.129.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Thu, 04 Mar 2004 11:25:33 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 15:16 +0000, Paulo Marques wrote:
> This patch corrected a problem for me, that happened when a printer presents an 
> out-of-paper status while printing a document. The driver would send endless 
> garbage to the printer.

This patch went in to 2.6.4-rc1, didn't it? It seems to have exacerbated
a problem which used to be occasional, but now seems to happen after
every print job.

I see the following, and the error repeats until I power cycle the
printer (HPLJ 1200 on AMD768 OHCI):

usb 1-1.3.2: control timeout on ep0in
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status



-- 
dwmw2

