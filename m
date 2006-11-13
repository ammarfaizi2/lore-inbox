Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933142AbWKMXKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142AbWKMXKC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933144AbWKMXKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:10:01 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17542 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933142AbWKMXKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:10:00 -0500
Date: Mon, 13 Nov 2006 18:09:23 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061113230923.GD13832@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <200611131822.44034.ak@suse.de> <20061113230156.GF1701@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113230156.GF1701@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 12:01:56AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > - Killed lots of dead code
> > > - Improve the cpu sanity checks to verify long mode
> > >   is enabled when we wake up.
> > > - Removed the need for modifying any existing kernel page table.
> > > - Moved wakeup_level4_pgt into the wakeup routine so we can
> > >   run the kernel above 4G.
> > > - Increased the size of the wakeup routine to 8K.
> > > - Renamed the variables to use the 64bit register names.
> > > - Lots of misc cleanups to match trampoline.S
> > > 
> > > I don't have a configuration I can test this but it compiles cleanly
> > > and it should work, the code is very similar to the SMP trampoline,
> > > which I have tested.  At least now the comments about still running in
> > > low memory are actually correct.
> > > 
> > > Vivek has tested this patch for suspend to memory and it works fine.
> > 
> > Suspend is unfortunately quite fragile.
> > 
> > pavel, rafael can you please test and review this patch? 
> 
> > (full patch is on l-k)
> 
> Based on comments, it looks like there'll be new version of patch,
> anyway? Vivek, would you cc me?
> 								Pavel

Hi Pavel,

Sure I will.

Thanks
Vivek 
