Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbSLDSLs>; Wed, 4 Dec 2002 13:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbSLDSLs>; Wed, 4 Dec 2002 13:11:48 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:9966 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S266997AbSLDSLo>; Wed, 4 Dec 2002 13:11:44 -0500
Date: Wed, 4 Dec 2002 19:19:00 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Alex Riesen <Alexander.Riesen@synopsys.COM>, linux-kernel@vger.kernel.org
Subject: Re: world read permissions on /proc/irq/prof_cpu_mask and ...smp_affinity
Message-ID: <20021204181900.GF26745@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <20021203114938.GD26745@riesen-pc.gr05.synopsys.com> <Pine.LNX.4.44.0212041036001.22730-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212041036001.22730-100000@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 10:37:01AM -0500, Ingo Molnar wrote:
> > Is there any reason to set the permissions to 0600?
> > It makes the admin to login as root just to look on the
> > current system state.
> > Is there something against 0644?
> 
> i've got nothing against 0644, 0600 was just the default paranoid value.  
> (reading it could in theory mean an IO-APIC read.)

The some objections against it (in vein: most people who want to
read it, supposed to want write into it).

But as for now it seems to be the only reason to have it readable
(and such things as /proc/ide/ideN/hdX/settings) is pure curiousity:
i don't really like to bother usually overworked admin to look at the
prof_cpu_mask just to figure out why all interrupts handled by CPU0.
And he is supposed to deny any my attempts to get root-SUID cat :)

-alex
