Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVCTXd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVCTXd0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCTXd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:33:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4516 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261335AbVCTXdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:33:07 -0500
Date: Sun, 20 Mar 2005 18:32:03 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386/x86_64 mpparse.c: kill maxcpus
Message-ID: <20050320233203.GC26230@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050320192549.GP4449@stusta.de> <20050320224233.GB26230@redhat.com> <20050320231232.GY4449@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320231232.GY4449@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 12:12:32AM +0100, Adrian Bunk wrote:
 > On Sun, Mar 20, 2005 at 05:42:34PM -0500, Dave Jones wrote:
 > > On Sun, Mar 20, 2005 at 08:25:49PM +0100, Adrian Bunk wrote:
 > >  > Do we really need a global variable that does only hold the value of 
 > >  > NR_CPUS?
 > > 
 > > Yes.
 > >  
 > > NR_CPUS = compile time
 > > maxcpus = boot command line at runtime.
 > 
 > If this is how is was expected to work - it isn't exactly what is 
 > currently implemented.

It's ugly, as its setting the same thing in two different places, but
I don't see any obvious reason why it won't work.

 > The function maxcpus in init/main.c sets a static variable max_cpus -
 > not the global variable maxcpus in the mpparse.c files.

Both variables are used differently. The arch specific var is only
used for HT descrimination. The init/main.c one is used for smp bringup.

 > How should it be?
 > 
 > Should max_cpus in init/main.c become global and replace the maxcpus 
 > from the mpparse.c files?

I'd just leave it as it is, as it seems to be working right now.

		Dave
