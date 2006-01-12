Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWALAFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWALAFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWALAFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:05:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964814AbWALAFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:05:51 -0500
Date: Wed, 11 Jan 2006 16:05:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: vgoyal@in.ibm.com
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Message-ID: <20060111160520.02c0ec73@dxpl.pdx.osdl.net>
In-Reply-To: <20060111134230.GE4990@in.ibm.com>
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net>
	<20060110184903.790d1a2c@localhost.localdomain>
	<20060111093212.GA15281@in.ibm.com>
	<200601111212.40989.ak@suse.de>
	<20060111134230.GE4990@in.ibm.com>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 19:12:30 +0530
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> On Wed, Jan 11, 2006 at 12:12:40PM +0100, Andi Kleen wrote:
> > On Wednesday 11 January 2006 10:32, Vivek Goyal wrote:
> > 
> > > Few x86_64 APIC related kexec changes are still in Andi's tree and have not
> > > been pushed to Linus tree. So there are no new x86_64 kexec patches in latest
> > > git repository.
> > > 
> > > Andrew has pushed x86_64 kdump related patches to Linus tree. And these become
> > > effective only under CONFIG_CRASH_DUMP. These patches are very less likely
> > > to botch with this stuff.
> > 
> > Yes, it was only a very quick look through the change log. Sorry for
> > hitting on you. I have no clue what could have broken. And my machines boot 
> > too with -git7 and his config.
> > 
> > Stephen, can you please do a binary search?
> > 
> 
> Andi,
> 
> While testing this I ran into another problem with same symtoms. If 
> I compile my kernel for physical location greater than or equal to 
> 16MB then only BP boots and applicatoin processors don't come up. I had
> noticed this problem in i386 and posted a patch. Here is the similar  patch 
> for x86_64.
> 
> Though the symtoms are same but this does not seem to be related to the
> problem which Stephen is facing as he seems to be compiling the kernel
> for 1MB location only.

Aha... Yes, this fixes the problem.
