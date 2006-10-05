Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWJEDLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWJEDLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 23:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWJEDLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 23:11:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32998 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750917AbWJEDLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 23:11:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<m11wpoeewn.fsf@ebiederm.dsl.xmission.com>
	<20061004142333.GA16218@in.ibm.com>
Date: Wed, 04 Oct 2006 21:09:35 -0600
In-Reply-To: <20061004142333.GA16218@in.ibm.com> (Vivek Goyal's message of
	"Wed, 4 Oct 2006 10:23:33 -0400")
Message-ID: <m13ba3cvbk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Hi Eric,
>
> Sure. I will get rid if ELF note generation for bzImage ELF header.
>
> But would that stop bootloaders out there from treating kernel as
> an ELF executable?

No.  The point of the notes is so that the bootloaders can look
at the kernel and have a strong hint what the right thing todo is.

The reason for taking them out is that what needs to happen is that
we need to put the notes into vmlinux and then copy the notes in
vmlinux into the bzImage.   Taking the notes out just make way
for us to put them back in properly.

> I have got a FC5 machine with grub version .97 and everything seems
> to work for me. So I am assuming that Andrew got a newer version of
> Grub which is trying to load ther kernel as an ELF executable and then
> running into the issues. 

We need to figure out how to reproduce this.

Eric
