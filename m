Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUGIUtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUGIUtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUGIUtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:49:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47260 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264579AbUGIUsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:48:52 -0400
To: Fawad Lateef <fawad_lateef@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need help in creating 8GB RAMDISK
References: <20040704092523.58214.qmail@web20806.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Jul 2004 14:46:14 -0600
In-Reply-To: <20040704092523.58214.qmail@web20806.mail.yahoo.com>
Message-ID: <m1brioc3jd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fawad Lateef <fawad_lateef@yahoo.com> writes:

> Hello
> 
> I am creating a RAMDISK of 7GB (from 1GB to 8GB). I
> reserved the RAM by changing the code in
> arch/i386/mm/init.c .......... 
> 
> But I am not able to access the RAM from 1GB to 8GB in
> a kernel module ........ after crossing the 4GB RAM,
> the system goes into standby state. But if I insert
> the same module 2 times means one for 1GB to 4GB and
> other for 4GB to 8GB. and mount them seprately both
> works fine ............ 
> 
> Can any one tell me the reason behind this ??? I think
> that in a single module we can't access more than 4GB
> RAM ...... If this is the reason then what to do ??? I
> need 7GB RAMDISK as a single drive ....

What do you need this for?

Mostly it looks like you just need to use kmap, but...
As other have pointed out ramfs is usually the better solution,
and you don't need to code anything.

Or are you trying to use an 7GB initrd.  An interesting idea
but that would take a little bootloader hacking to make work.

Eric
