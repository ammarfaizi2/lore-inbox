Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030831AbWJDL5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030831AbWJDL5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWJDL5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:57:47 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:1250 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1030831AbWJDL5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:57:46 -0400
Message-Id: <4523BE20.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 04 Oct 2006 13:58:56 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Eric Rannaud" <eric.rannaud@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <nagar@watson.ibm.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <200609302230.24070.ak@suse.de> <45239A38.76E4.0078.0@novell.com>
 <200610041252.48721.ak@suse.de>
In-Reply-To: <200610041252.48721.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Proposed patch appended. Jan, what do you think?
>> 
>> As said above - I thought we added zero-termination already.
>
>For head.S but not for kernel_thread I think. At least I can't
>find any existing code for kernel_thread().

2.6.18-git11 (i386) already has an annotated version of
kernel_thread_helper() in entry.S, including the pushing of a
fake (zero) return address. x86-64 has child_rip with the
added push even in original 2.6.18.

Jan
