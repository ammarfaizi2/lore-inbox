Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbUKXUP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbUKXUP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbUKXUP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:15:59 -0500
Received: from zeus.kernel.org ([204.152.189.113]:13191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262830AbUKXUPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:15:53 -0500
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
From: Arjan van de Ven <arjan@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1101314988.1714.194.camel@mulgrave>
References: <1101314988.1714.194.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1101323621.2811.24.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 24 Nov 2004 20:13:41 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've not been able to trace an exact cause for this, but it does seem to
> be pretty much eliminated by lowering the clock speed to 100HZ.  I
> propose the following patch to do this for the slower intel processors
> (basically pentiums and below)


while I agree with 100Hz for slower cpus, I rather have a config option for it so people
(and distros) can select it independent of the exact cpu type they want to compile a kernel for

