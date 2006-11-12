Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755054AbWKLLSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbWKLLSB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 06:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbWKLLSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 06:18:01 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:62146 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1755053AbWKLLSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 06:18:01 -0500
In-Reply-To: <200611121005.58939.bero@arklinux.org>
References: <200611112334.28889.bero@arklinux.org> <4556D9C0.3050103@qumranet.com> <200611121005.58939.bero@arklinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1BA58C04-16BE-4EEA-AD24-20C4089DA0BF@kernel.crashing.org>
Cc: Avi Kivity <avi@qumranet.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
Date: Sun, 12 Nov 2006 12:17:55 +0100
To: Bernhard Rosenkraenzer <bero@arklinux.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> drivers/kvm/kvm_main.c: In function 'kvm_dev_ioctl_run':
>>> drivers/kvm/kvm_main.c:153: error: 'asm' operand has impossible
>>> constraints drivers/kvm/kvm_main.c:158: error: 'asm' operand has
>>> impossible constraints
>>
>> Smells like a gcc regression.  Can you send .config?
>>
>> Or better yet, preprocessed source and full gcc command line (as  
>> seen on
>> 'make V=1').

Just the function containing those lines (please mark which
lines they are) would do probably.

> It does look like a gcc bug -- -O0 makes it go away.
> Details at http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29808

PR29808 is not a GCC bug, but invalid code.


Segher

