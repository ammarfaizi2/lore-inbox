Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269586AbTGKEXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 00:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269774AbTGKEXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 00:23:53 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:46856 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S269586AbTGKEXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 00:23:51 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'David D. Hagood'" <wowbagger@sktc.net>,
       "'Alan Stern'" <stern@rowland.harvard.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Style question: Should one check for NULL pointers?
Date: Thu, 10 Jul 2003 21:38:29 -0700
Organization: Cisco Systems
Message-ID: <01c701c34766$4706cc50$743147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <3F0DEEA4.5050605@sktc.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is an old saying in software design:
> 
> "Never check for an error condition that you do not know how 
> to handle."
> 
> In other words: if you have identified a possible error 
> condition (such as a NULL pointer), until you have identified a way to
meaningfully 
> handle that error condition, simply testing for it is useless.
> Now, if you have some function that can return an error code, then 
> testing for NULL and returning an error condition is sensible. But if 
> you have no way to report the error, then what good is the test?

Not always true. In some cases you know how to handle: just return
without doing anyting.

man 3 free

It's an example that passing a NULL is allowed by the API.
 
> However, if you test for NULL, and log a report when you 
> detect it then 
> deref it anyway (to force an OOPS, in other words throw an 
> exception), 
> then at least there is some meaningful info in the log.
> 
> But just doing something like
> 
> void foo(void *ptr)
> {
>     if (!ptr)
>       return;
> 
>     ....
> }
> 
> just masks the problem.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

