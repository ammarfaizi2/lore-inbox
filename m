Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVLFQ4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVLFQ4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVLFQ4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:56:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27525 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932333AbVLFQ4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:56:40 -0500
Date: Tue, 6 Dec 2005 11:56:07 -0500
From: Dave Jones <davej@redhat.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051206165607.GA440@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe> <20051205011611.GA12664@redhat.com> <20051205130224.GC17993@harddisk-recovery.com> <20051205172513.GB12664@redhat.com> <20051206111349.GB32737@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206111349.GB32737@harddisk-recovery.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 12:13:49PM +0100, Erik Mouw wrote:
 > On Mon, Dec 05, 2005 at 12:25:13PM -0500, Dave Jones wrote:
 > > On Mon, Dec 05, 2005 at 02:02:24PM +0100, Erik Mouw wrote:
 > >  > If you want a userspace governor to change the CPU speed, you need to
 > >  > export the value to userland. 
 > > 
 > > We have sysfs files for that.
 > 
 > Earlier in this thread you said (I should have quoted that, my fault):
 > 
 >   Adding any other interface to obtain this value is equally as broken.
 > 
 > So I'm confused, sysfs one of the "any other interfaces"...

userspace governors need to know the available frequencies to scale to, 
which they obtain from sysfs. In addition, we maintain an index as to
which of those is currently chosen.  However, programs should not rely
on this to be a "how fast is my CPU" status, as it's totally meaningless.
It's there purely for humans to see "Yes, X < Y, so I'm going at the
lower of the frequencies my CPU can do", not for programs to calculate
delays loops and such.

		Dave


