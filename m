Return-Path: <linux-kernel-owner+willy=40w.ods.org-S380006AbUKBHgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S380006AbUKBHgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S375835AbUKBHgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:36:12 -0500
Received: from plus.ds14.agh.edu.pl ([149.156.124.14]:48567 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S447731AbUKBHfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:35:36 -0500
Date: Tue, 2 Nov 2004 08:35:34 +0100 (CET)
From: Pawel Sikora <pluto@pld-linux.org>
X-X-Sender: pld@plus.ds14.agh.edu.pl
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oops] lib/vsprintf.c
In-Reply-To: <418728CA.1090707@yahoo.com.au>
Message-ID: <Pine.LNX.4.60.0411020826520.12803@plus.ds14.agh.edu.pl>
References: <200411020719.55570.pluto@pld-linux.org> <418728CA.1090707@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Nov 2004, Nick Piggin wrote:

> Pawe Sikora wrote:
>> Hi,
>> 
>> vsprintf.c-      case 's':
>> vsprintf.c-                    s = va_arg(args, char *);
>> vsprintf.c-                    if ((unsigned long)s < PAGE_SIZE)
>> vsprintf.c-                           s = "<NULL>";
>> vsprintf.c-
>> vsprintf.c:      OOPS!  =>     len = strnlen(s, precision);
>> 
>
> But it is the kernel module that's buggy. What's the problem?
>
>

I think that block similar to setjmp/longjmp should be placed
around such dangerous places to refues future oops.
That's all.
