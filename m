Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267295AbSLELUL>; Thu, 5 Dec 2002 06:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267297AbSLELUL>; Thu, 5 Dec 2002 06:20:11 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:61941 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S267295AbSLELUK>; Thu, 5 Dec 2002 06:20:10 -0500
Date: Thu, 5 Dec 2002 12:24:21 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Sean Neakums <sneakums@zork.net>
Subject: Re: world read permissions on /proc/irq/prof_cpu_mask and ...smp_affinity
Message-ID: <20021205112421.GG26745@riesen-pc.gr05.synopsys.com>
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
> 

Just found a patch from Olaf Dietsche (2.5.40: fix chmod/chown on procfs).
Quote:
  This patch allows to change uid, gid and mode of files and directories
  located in procfs.

The patch was accepted 2.5.

This perfectly solves the problem, and in very clean way, i think.

-alex
