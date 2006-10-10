Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWJJSqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWJJSqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWJJSqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:46:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751079AbWJJSqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:46:49 -0400
Date: Tue, 10 Oct 2006 11:46:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-Id: <20061010114618.9f520f90.akpm@osdl.org>
In-Reply-To: <20061010143044.GA9645@in.ibm.com>
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
	<20061010143044.GA9645@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 10:30:44 -0400
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
> > I'll consolidate the patches which I have now and then I'll drop them.
> > 
> 
> Hi Andrew,
> 
> I will find a machine having lilo and look into the issue. 

Thanks.

> Instead of dropping all the patches, can't we just drop the last patch which
> adds an elf header.

Yes, that patch was the cause.

> Most likely this issue should be happening because of
> that patch. Rest of the patches should be harmless.

Those patches had reached my tolerance threshold and other people want to
make changes to vmlinux.lds.S, and having large and uncertain changes in
there makes that harder for them.

Resend them when you think they're ready for another run please.
