Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966449AbWKNXSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966449AbWKNXSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966448AbWKNXSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:18:22 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:46043 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S966460AbWKNXSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:18:21 -0500
Date: Tue, 14 Nov 2006 18:17:42 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061114231742.GE7030@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <20061114163002.GB4445@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114163002.GB4445@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 04:30:03PM +0000, Pavel Machek wrote:
> Hi!
> 
> > - Killed lots of dead code
> > - Improve the cpu sanity checks to verify long mode
> >   is enabled when we wake up.
> > - Removed the need for modifying any existing kernel page table.
> > - Moved wakeup_level4_pgt into the wakeup routine so we can
> >   run the kernel above 4G.
> > - Increased the size of the wakeup routine to 8K.
> > - Renamed the variables to use the 64bit register names.
> > - Lots of misc cleanups to match trampoline.S
> > 
> > I don't have a configuration I can test this but it compiles cleanly
> 
> Ugh, now that's a big patch.. and untested, too :-(.
> 
> Why is PGE no longer required, for example?
> 
> Can we get it piece-by-piece?
> 
> > Vivek has tested this patch for suspend to memory and it works fine.
> 
> Ok, so it was tested on one config. Given that the patch deals with
> detecting CPU oddities... :-(

Hi Pavel,

This code has been lying in RHEL kernels for close to 3 months now.
Have not heard of suspend/resume complaints. So hoping it got
tested on wide variety of hardware too apart from testing on my machine.

Thanks
Vivek
