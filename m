Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWJKCgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWJKCgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 22:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWJKCgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 22:36:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932404AbWJKCgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 22:36:24 -0400
Date: Tue, 10 Oct 2006 19:35:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-Id: <20061010193538.df4a60ed.akpm@osdl.org>
In-Reply-To: <20061010214025.GC10925@in.ibm.com>
References: <20061004233137.97451b73.akpm@osdl.org>
	<m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
	<20061005235909.75178c09.akpm@osdl.org>
	<m1bqop38nw.fsf@ebiederm.dsl.xmission.com>
	<20061006183846.GF19756@in.ibm.com>
	<4526A66B.4030805@zytor.com>
	<m1ac49z2fl.fsf@ebiederm.dsl.xmission.com>
	<4526D084.1030700@zytor.com>
	<20061009143345.GB17572@in.ibm.com>
	<20061009201418.81bf0acd.akpm@osdl.org>
	<20061010214025.GC10925@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 17:40:25 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> On Mon, Oct 09, 2006 at 08:14:18PM -0700, Andrew Morton wrote:
> > On Mon, 9 Oct 2006 10:33:45 -0400
> > Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > 
> > > Please find attached the regenerated patch.
> > 
> > Somewhere amongst the six versions of this patch, the kernel broke.  Seems
> > that the kernel command line isn't getting recognised.  The machine is
> > running LILO and RH FC1.
> > 
> 
> Hi Andrew,
> 
> I tried lilo 22.7.3 with FC6 Test2 with 2.6.19-rc1 and all the relocatable
> patches and things work fine for me. Commnand line is also being recognized
> properly.

This is FC1.

> Looks like something specific to your setup. Can you please provide some
> more details
> 
> - Do you see any failure messages?

Tricky.  No command line means no serial console, no netconsole.

> - Can you please provide your /etc/lilo.conf file.

Various stuff at http://userweb.kernel.org/~akpm/vmm/

> - What lilo version are you using?

vmm:/boot> lilo -v       
LILO version 21.4-4, Copyright (C) 1992-1998 Werner Almesberger
'lba32' extensions Copyright (C) 1999,2000 John Coffman

> - Can you please also upload your kernel config file.

See above.
