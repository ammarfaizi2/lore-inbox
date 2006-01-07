Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030616AbWAGWOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030616AbWAGWOI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030617AbWAGWOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:14:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:64916 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030616AbWAGWOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:14:05 -0500
Subject: Re: Platform device matching, & weird strncmp usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kurtis D. Rader" <kdrader@us.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060107192458.GA12409@us.ibm.com>
References: <1136527179.4840.120.camel@localhost.localdomain>
	 <20060107192458.GA12409@us.ibm.com>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 09:14:59 +1100
Message-Id: <1136672100.30123.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I can't speak to the correctness of that code but your understanding of
> strncmp() is incorrect. From "GNU C Library Application Fundamentals":
> 
>     This function is the [sic] similar to strcmp, except that no more
>     than size wide characters are compared. In other words, if the two
>     strings are the same in their first size wide characters, the return
>     value is zero.
> 
> And this has been may experience for the past 20 years and is confirmed by
> this trivial program which prints zero in both cases:
> 
> #include <string.h>
> #include <stdio.h>
> int main() {
>     printf("%d\n", strncmp("abc","abcd",3));
>     printf("%d\n", strncmp("abcd","abc",3));
> }

Except that in my example, the count was larger than both strings...

Anyway, it happens to not be a problem as the string I was comparing was
not in fact different.

Ben.


