Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWAZE5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWAZE5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 23:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWAZE5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 23:57:50 -0500
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:40926 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751096AbWAZE5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 23:57:49 -0500
Date: Wed, 25 Jan 2006 20:55:10 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Greg KH <greg@kroah.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
Message-ID: <20060126045510.GA10962@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com> <1137775645.28944.61.camel@serpentine.pathscale.com> <20060124150912.GB7130@frankl.hpl.hp.com> <1138219693.15295.13.camel@serpentine.pathscale.com> <20060125235204.GB21195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125235204.GB21195@kroah.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Wed, Jan 25, 2006 at 03:52:04PM -0800, Greg KH wrote:
> On Wed, Jan 25, 2006 at 12:08:13PM -0800, Bryan O'Sullivan wrote:
> > On Tue, 2006-01-24 at 07:09 -0800, Stephane Eranian wrote:
> > 
> > > Because I tried regrouping all the /proc AND related interface into a single
> > > C file.
> > 
> > sysctls seem to be every bit as deprecated as /proc for what you are
> > tring to do.
> > 
> > > Well, it is not clear to me what criteria is used for /sys vs /proc.
> > 
> > My understanding is that only process-related stuff belongs in /proc
> > now.  Other random cruft that has accumulated over the years is left
> > there for backwards compatibility, but /sys interfaces are the way
> > forward now.
> 
> Yes, that is exactly right.
> 
I don't have a problem moving the perfmon stuff to /sys, except for
/proc/perfmon which is already being used by a bunch of tools. Unless
we duplicate the information or use a simlink (if that's possible).

Please indicate a location in the /sys tree where these would fit:

/proc/perfmon
/proc/perfmon_map

These are currently sysctl():

/proc/sys/kernel/perfmon/arg_size_max
/proc/sys/kernel/perfmon/debug
/proc/sys/kernel/perfmon/debug_ovfl
/proc/sys/kernel/perfmon/expert_mode
/proc/sys/kernel/perfmon/reset_stats
/proc/sys/kernel/perfmon/smpl_buf_size_max
/proc/sys/kernel/perfmon/sys_group
/proc/sys/kernel/perfmon/task_group

-- 
-Stephane
