Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVAWLEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVAWLEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 06:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVAWLEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 06:04:09 -0500
Received: from canuck.infradead.org ([205.233.218.70]:22788 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261273AbVAWLEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 06:04:06 -0500
Subject: Re: [2.6 patch] loop.c: make two functions static
From: Arjan van de Ven <arjanv@infradead.org>
To: andyliu <liudeyan@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <aad1205e050123023214c4fa5c@mail.gmail.com>
References: <20050123101710.GJ3212@stusta.de>
	 <aad1205e050123023214c4fa5c@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 12:03:50 +0100
Message-Id: <1106478230.6129.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-23 at 18:32 +0800, andyliu wrote:
> hi, adrian
> 
> i always see patches which set functions and variables to static.
> what's the main difference between static and non-static things?

1) namespace; static functions/variables are not visible name wise to
other .c files
2) optimisation: because of 1), gcc can know that there are no outside
users (assuming also no address-off is taken, which gcc also knows), and
in that case gcc can do a series of extra optimisations (such as more
agressive inlining, since gcc knows the exact user count of the function
now, but also gcc 3.4 will do things like make the function be regparm=3
equivalent, tail/head optimisations are possible (eg partial inlining)



