Return-Path: <linux-kernel-owner+w=401wt.eu-S1752928AbWLQQZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbWLQQZ0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 11:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbWLQQZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 11:25:26 -0500
Received: from smtpout.mac.com ([17.250.248.183]:50143 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbWLQQZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 11:25:25 -0500
In-Reply-To: <orwt4qaara.fsf@redhat.com>
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org> <orwt4qaara.fsf@redhat.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <86C272DA-23BA-4901-994D-6CABCC87A2DE@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ricardo Galli <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL only modules
Date: Sun, 17 Dec 2006 11:25:01 -0500
To: Alexandre Oliva <aoliva@redhat.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 17, 2006, at 08:54:17, Alexandre Oliva wrote:
> On Dec 16, 2006, Linus Torvalds <torvalds@osdl.org> wrote:
>> Do you REALLY believe that a binary becomes a "derived work" of  
>> any random library that it gets linked against? If that's not  
>> "fair use" of a library that implements a standard library  
>> definition, I don't know what is.
>
> Some disregard the fact that header files sometimes aren't just  
> interface definitions, but they also contain functional code, in  
> the form of preprocessor macros and inline functions, that, if  
> used, do make it to the binary.

I would argue that this is _particularly_ pertinent with regards to  
Linux.  For example, if you look at many of our atomics or locking  
operations a good number of them (depending on architecture and  
version) are inline assembly that are directly output into the code  
which uses them.  As a result any binary module which uses those  
functions from the Linux headers is fairly directly a derivative work  
of the GPL headers because it contains machine code translated  
literally from GPLed assembly code found therein.  There are also a  
fair number of large perhaps-wrongly inline functions of which the  
use of any one would be likely to make the resulting binary  
"derivative".

On the other hand, certain projects like OpenAFS, while not license- 
compatible, are certainly not derivative works.  The project was  
created independently of Linux and operates on several different  
operating systems, so even though it uses the very-Linux-specific  
keyring interfaces under 2.6, no GPL licensing could possibly apply.

> The gray area between what is clearly permitted by a license and  
> the murky lines that determine what constitutes a derived work, and  
> what is fair use even if it's a derived work, is not for any of us  
> to decide. The best we can do is to offer interpretations on intent  
> of license authors and software authors, and of laws.  Even though  
> we're not lawyers or judges, such interpretations may be taken into  
> account in court disputes.

I agree, and I think that this thread has outlived its useful life.

Cheers,
Kyle Moffett


