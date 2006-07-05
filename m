Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWGEPxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWGEPxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWGEPxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:53:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20146 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932419AbWGEPxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 11:53:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at>
	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
	<44A0CCEA.7030309@ed-soft.at>
	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
	<44A304C1.2050304@zytor.com>
	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
	<44A8058D.3030905@zytor.com>
	<m11wt3983j.fsf@ebiederm.dsl.xmission.com>
	<44AB8878.7010203@ed-soft.at>
Date: Wed, 05 Jul 2006 09:52:48 -0600
In-Reply-To: <44AB8878.7010203@ed-soft.at> (Edgar Hucek's message of "Wed, 05
	Jul 2006 11:38:00 +0200")
Message-ID: <m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Hucek <hostmaster@ed-soft.at> writes:

> I agre with you to make efi use the e820 map as a long term solution.
> But at the moment the efi part is completley broken without my patch.

But your patch isn't a fix.  It is a hack to make the system boot.

A patch that performed the same check on the efi memory map,
or it converted the efi memory map to use an e820 map it would be a fix.

> At least on Intel Macs. 
> Without the patch also my Imacfb driver makes no sense, since it is 
> for efi booted Intel Macs. 

My point is that the kernel efi support is broken.  You have just found
the location where the bone is poking through the skin.

I am tempted to write a patch to delete the x86 efi support at this
point.  So that it is very clear that it needs to be completely redone.

Eric
