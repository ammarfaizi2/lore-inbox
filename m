Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755032AbWKLJYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbWKLJYw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 04:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755033AbWKLJYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 04:24:51 -0500
Received: from il.qumranet.com ([62.219.232.206]:3716 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1755031AbWKLJYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 04:24:51 -0500
Message-ID: <4556E860.700@qumranet.com>
Date: Sun, 12 Nov 2006 11:24:48 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
References: <200611112334.28889.bero@arklinux.org> <4556D9C0.3050103@qumranet.com> <200611121005.58939.bero@arklinux.org>
In-Reply-To: <200611121005.58939.bero@arklinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> On Sunday, 12. November 2006 09:22, Avi Kivity wrote:
>   
>> Bernhard Rosenkraenzer wrote:
>>     
>>> drivers/kvm/kvm_main.c: In function 'kvm_dev_ioctl_run':
>>> drivers/kvm/kvm_main.c:153: error: 'asm' operand has impossible
>>> constraints drivers/kvm/kvm_main.c:158: error: 'asm' operand has
>>> impossible constraints
>>>       
>> Smells like a gcc regression.  Can you send .config?
>>
>> Or better yet, preprocessed source and full gcc command line (as seen on
>> 'make V=1').
>>     
>
> It does look like a gcc bug -- -O0 makes it go away.
> Details at http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29808
>   

That's a different bug, gcc generates code that the assembler can't 
handle.  Might be an assembler bug.

Can you compile it with -S and post the generated assembly?

-- 
error compiling committee.c: too many arguments to function

