Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbWCVUlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWCVUlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWCVUlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:41:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:27789 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932714AbWCVUlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:41:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: Linux v2.6.16
Date: Wed, 22 Mar 2006 21:40:00 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <200603221911.06576.rjw@sisk.pl> <20060322102717.A12901@unix-os.sc.intel.com>
In-Reply-To: <20060322102717.A12901@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222140.00912.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 19:27, Ashok Raj wrote:
> On Wed, Mar 22, 2006 at 07:11:05PM +0100, Rafael J. Wysocki wrote:
> > > It might help to explain why this would break your swsusp with SMP work?
> > 
> > On SMP systems swsusp (suspend in general, AFAICT) uses the disable_nonboot_cpus()
> > function defined in kernel/power/smp.c, which calls cpu_down() that is only
> > defined if CONFIG_HOTPLUG_CPU is set.  We can't suspend and resume SMP systems
> > reliably without it.
> > 
> I understand the needs of swsusp, but no one took away CONFIG_HOTPLUG_CPU away... 
> just that you need to also enable CONFIG_GENERICARCH to get it to work reliably, and
> not see that printk... nothing else..
> 
> Iam still confused why you think swsusp wont work...
> 
> with that patch, try
> 
> CONFIG_X86_PC=n
> CONFIG_GENERICARCH=y
> CONFIG_HOTPLUG_CPU=y

Well, there's nothing like CONFIG_GENERICARCH on x86_64 or I'm obviously
missing something. :-)

On x86_64 I can choose between X86_PC and X86_VSMP and I'm not sure I'd like
to set X86_VSMP just in order to be able to suspend a box with a dual-core CPU.
IMHO that would be over the top.

Greetings,
Rafael
