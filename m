Return-Path: <linux-kernel-owner+w=401wt.eu-S1422936AbWLUNng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422936AbWLUNng (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422943AbWLUNng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:43:36 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:46165 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422936AbWLUNnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:43:35 -0500
Date: Thu, 21 Dec 2006 08:43:26 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061221031326.GC30299@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221102232.5a10bece.khali@linux-fr.org> <m164c5pmim.fsf@ebiederm.dsl.xmission.com> <20061221010814.GA30299@in.ibm.com> <20061221141354.6d9ec3e6.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221141354.6d9ec3e6.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 02:13:54PM +0100, Jean Delvare wrote:
> On Thu, 21 Dec 2006 06:38:14 +0530, Vivek Goyal wrote:
> > On Thu, Dec 21, 2006 at 03:32:33AM -0700, Eric W. Biederman wrote:
> > > Grr.  I guessed the problem was to late in the game it seems the problem
> > > is in setup.S  Before we switch to 32bit mode.
> > >
> > > Ok.  There is almost enough for inference but here is a patch of stops
> > > for setup.S let's see if one of those will stop the reboots.
> > >
> > > I have a strong feeling that we are going to find a tool chain issue,
> > > but I'd like to find where we ware having problems before we declare
> > > that to be the case.
> >
> > Looks like it might be a tool chain issue. I took Jean's config file and
> > built my own kernel and I am able to boot the kernel. But I can't boot
> > his bzImage. I observed the same behaviour as jean is experiencing. It jumps
> > back to BIOS.
> 
> I can only confirm that. I installed a more recent system on the same
> hardware, rebuilt a kernel from the same config file, and now it boots
> OK. So it's not related to the hardware. It has to be a compilation-time
> issue.
> 

Hi Jean,

Looks like you have already trashed your setup. If not, is it possible to
upload the output of "objdump -D arch/i386/boot/setup.o"? This will give
some info regarding what assembler is doing.

Thanks
Vivek
