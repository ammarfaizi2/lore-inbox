Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263050AbTC1Q6Y>; Fri, 28 Mar 2003 11:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263052AbTC1Q6Y>; Fri, 28 Mar 2003 11:58:24 -0500
Received: from [81.2.110.254] ([81.2.110.254]:6908 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263050AbTC1Q6T>;
	Fri, 28 Mar 2003 11:58:19 -0500
Subject: Re: x.25 bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tiaan Wessels <tiaan@netsys.co.za>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303280600.h2S60YC02395@tiaan.netsys.co.za>
References: <200303280600.h2S60YC02395@tiaan.netsys.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048871461.5056.29.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 17:11:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 06:00, Tiaan Wessels wrote:
> [X.] Other notes, patches, fixes, workarounds:
> in net/x25/x25_facilities.c function x25_parse_facilities
> there is switch with case X25_FAC_CLASS_D which has code
> 
> p   += p[1] + 2;
> len -= p[1] + 2;
> 
> the problem is in decrementing len, p is used after it was modified
> in previous statement. i suspect cut-and-paste here. to fix one
> would put p[1] in temp variable of unsigned char first and then use
> this instead of p[1] in these statements. if this is not done and
> a call arrives with class D facilities, we see a faint blinking of
> the eye before lights goes out.
> 
> can someone more familiar with the kernel patch process please update
> the latest sources.

PS: In the mean time if nobody else is looking at it, I'll take a look
at this bit too

