Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSJRSiK>; Fri, 18 Oct 2002 14:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265261AbSJRSiK>; Fri, 18 Oct 2002 14:38:10 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:60688
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265250AbSJRSiK>; Fri, 18 Oct 2002 14:38:10 -0400
Subject: Re: [PATCH] 2.4: variable HZ
From: Robert Love <rml@tech9.net>
To: Neil Conway <nconway.list@ukaea.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DAFF5C9.807BE885@ukaea.org.uk>
References: <3DAFF5C9.807BE885@ukaea.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 14:44:16 -0400
Message-Id: <1034966657.722.838.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 07:51, Neil Conway wrote:

> I was looking at your jiffies_to_clock_t() macro, and I notice that it
> will screw up badly if the user chooses a HZ value that isn't a multiple
> of the normal value (e.g. 1000 is OK, 512 isn't).

OK, sure, but why specify a power-of-two HZ?  There is absolutely no
reason to, at least on x86.

Want 512?  500 will do just as well and has the benefit of (a) being a
multiple of the previous HZ and (b) evenly dividing into our concept of
time.

	Robert Love

