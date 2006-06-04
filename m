Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932319AbWFDXai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWFDXai (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFDXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:30:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932303AbWFDXah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:30:37 -0400
Date: Sun, 4 Jun 2006 16:24:53 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: dwmw2@infradead.org, rmk@arm.linux.org.uk, gregkh@suse.de,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        zaitcev@redhat.com
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-Id: <20060604162453.696f190b.zaitcev@redhat.com>
In-Reply-To: <20060604201223.7cd37936@home.brethil>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<20060601234833.adf12249.zaitcev@redhat.com>
	<1149242609.4695.0.camel@pmac.infradead.org>
	<20060602154723.54704081.zaitcev@redhat.com>
	<20060604201223.7cd37936@home.brethil>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 20:12:23 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:

> | I understand. My intent was different, however. One of the bigger sticking
> | points for usb-serial was its interaction with line disciplines, which are
> | notorious for looping back and requesting writes from callbacks
> | (e.g. h_hdlc.c). They are also sensitive to drivers lying about the
> | amount of free space in their FIFOs. This is something you never test
> | when driving a serial port from an application, no matter how cleverly
> | written.

>   In all the tests the modem was configured to answer the calls, and the
> cell phone was configured to dial to the modem (my home's number).

This is exactly backwards, and so it tests different code paths.
The line discipline is involved into driving a cooked mode port,
e.g. the one where getty is.

Running uploads and downloads with things like xmodem is a good
test of hardware flow control, so someone will have to do it too.

>  Unfortunatally this is a very expensive test environment, and I can't use
> it for development. The best one would be to have a USB<->DB9 cable..

PL-2303 already has a DB-9, you actually you need a DB-9-to-DB-9
Null Modem (cross-over) cable.

Anyway, I do not expect pl2303 failing this test, mind. It's more
of a problem for simpler devices.

-- Pete
