Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWCJOhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWCJOhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCJOhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:37:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:29636 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751356AbWCJOhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:37:13 -0500
Date: Fri, 10 Mar 2006 15:37:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Markus Gutschke <markus@google.com>, linux-kernel@vger.kernel.org,
       dkegel@google.com
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on
 i386
In-Reply-To: <20060309184759.591e3551.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0603101536320.23690@yvahk01.tjqt.qr>
References: <4410BB32.1020905@google.com> <20060309184759.591e3551.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Gcc reserves %ebx when compiling position-independent-code on i386. This 
>>  means, the _syscallX() macros in include/asm-i386/unistd.h will not 
>>  compile. This patch is against 2.6.15.6 and adds a new set of macros 
>>  which will be used in PIC mode. These macros take special care to 
>>  preserve %ebx.
>
>But we don't compile the kernel with -fpic...  We might want to, for kdump
>convenience at some stage, perhaps.
>
UML. Maybe it does not build with -fpic/-fPIC either, but it's one case 
where it's more likely than with a "true" kernel.


Jan Engelhardt
-- 
