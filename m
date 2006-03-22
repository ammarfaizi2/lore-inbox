Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWCVRlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWCVRlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWCVRk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:40:58 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:7820 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932228AbWCVRkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:40:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: Linux v2.6.16
Date: Wed, 22 Mar 2006 18:39:41 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <20060321223120.A4003@unix-os.sc.intel.com> <20060322050837.A9452@unix-os.sc.intel.com>
In-Reply-To: <20060322050837.A9452@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221839.41867.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 14:08, Ashok Raj wrote:
> On Tue, Mar 21, 2006 at 10:31:20PM -0800, Ashok Raj wrote:
> > On Tue, Mar 21, 2006 at 09:22:41PM -0800, Peter Williams wrote:
> > > 
> > >    I/O APICs
> > >    Mar 22 16:10:31 heathwren kernel: More than 8 CPUs detected and
> > >    CONFIG_X86_PC cannot handle it.
> > > 
> > >    ###  No more CPUs seen but something in there thinks there's more than
> > >    8
> > >    of them.
> > > 
> > >    Mar 22 16:10:31 heathwren kernel: Use CONFIG_X86_GENERICARCH or
> > >    CONFIG_X86_BIGSMP.
> > > 
> > 
> > 
> 
> Hi Andrew
> 
> Please consider for inclusion... resending with changelog per Andrew.

Please don't apply this patch.

CPU hotplug is used by swsusp for disabling the nonboot CPUs.  Software
suspend won't work on SMP without CPU hotplugging.

Greetings,
Rafael
