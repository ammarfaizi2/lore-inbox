Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUHZAtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUHZAtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUHZAtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:49:12 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:131 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266173AbUHZAtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:49:11 -0400
Date: Thu, 26 Aug 2004 01:48:57 +0100
From: Dave Jones <davej@redhat.com>
To: Dan Hollis <goemon@anime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bizarre 2.6.8.1 /sys permissions
Message-ID: <20040826004857.GA5583@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dan Hollis <goemon@anime.net>, linux-kernel@vger.kernel.org
References: <20040825221814.GA20283@redhat.com> <Pine.LNX.4.44.0408251630380.17580-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408251630380.17580-100000@sasami.anime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 04:31:50PM -0700, Dan Hollis wrote:
 > >  > $ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
 > >  > cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission denied
 > > Reading this file causes reads from hardware on some cpufreq drivers.
 > > This can be a slow operation, so a user could degrade system performance
 > > for everyone else by repeatedly cat'ing it.
 > 
 > any reason why cpuinfo_cur_freq cant read cpu_khz ?

cpufreq_cur_freq will be one of scaling_available_frequencies.
These are usually a value such as 1300MHz, where cpu_mhz is a
'measured' value and will look something like 1303.852

the values cpufreq uses are the values either returned by the
hardware as its settable states, or from BIOS tables defining
those states.

 > or rather, is there any reason why cpuinfo_cur_freq and /proc/cpuinfo 
 > should legitimately differ?

They aren't identical, and serve different purposes.

		Dave

