Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbTCLRcC>; Wed, 12 Mar 2003 12:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbTCLRcC>; Wed, 12 Mar 2003 12:32:02 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:43446 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261817AbTCLRcB>; Wed, 12 Mar 2003 12:32:01 -0500
Date: Wed, 12 Mar 2003 17:40:01 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Christopher Meredith <theophile@saintmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PowerNow!, cpufreq, and swsusp
Message-ID: <20030312183954.GA13653@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Christopher Meredith <theophile@saintmail.net>,
	linux-kernel@vger.kernel.org
References: <3e6f6919.1546.10699@saintmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6f6919.1546.10699@saintmail.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 12:06:33PM -0500, Christopher Meredith wrote:

 > Also, cpufreq doesn't seem to do anything. Should it be
 > working automatically?

no.

 > Even when the machine sits unattended
 > for over 8 hours, the fan never turns off and the cpu
 > temperature is consustently 69-70 degrees C.

The kernel doesn't define policy, but exposes the necessary
interface to userspace.  There are a few folks working on
tools / scripts to adjust the speed dynamically.
look through the cpufreq mailing list archives to find them
(or google)

 > What must I do here?

Read Documentation/cpu-freq/user-guide.txt

short: mount sysfs, and ..

(root@evo:cpufreq)# cd /sys/class/cpu/cpufreq/cpu0/cpufreq
(root@evo:cpufreq)# cat /proc/cpuinfo | grep MHz
cpu MHz		: 1390.536
(root@evo:cpufreq)# echo powersave >scaling_governor
(root@evo:cpufreq)# cat /proc/cpuinfo | grep MHz
cpu MHz		: 529.728
(root@evo:cpufreq)# echo performance >scaling_governor

		Dave

