Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbTGOR6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269223AbTGOR5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:57:33 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:23710 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269190AbTGOR4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:56:23 -0400
Date: Tue, 15 Jul 2003 19:11:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: Matt Reppert <repp0017@tc.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.0-test1
Message-ID: <20030715181100.GF15505@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Dominik Brodowski <linux@brodo.de>,
	Matt Reppert <repp0017@tc.umn.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org> <20030715001132.3b0fd7a5.repp0017@tc.umn.edu> <20030715105657.GA13879@suse.de> <20030715173844.GB1950@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715173844.GB1950@brodo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 07:38:44PM +0200, Dominik Brodowski wrote:

 > No, please don't do this. There is no function at all in the cpufreq core 
 > which may be called with CPUFREQ_ALL_CPUS as arguments. Well, there had 
 > been, many months ago. But it really shall not be defined or used anywhere 
 > outside the 2.4. proc-intf any more.

ick, you're right of course.

 > Now, wrt the ppc-cpufreq driver: benh's 2.5. tree includes a much more
 > updated version than plain 2.6.0-test1 -- Ben, can you push that to Linus,
 > please? Also, please change the line 
 >  	freqs.cpu = CPUFREQ_ALL_CPUS;
 > in do_set_cpu_speed() to 
 > 	freqs.cpu = 0;
 > which is the way it should be done now.

Ok, CPUFREQ_ALL_CPUS is no more in my pending tree.
Documentation/cpu-freq/core.txt is also out of date and could use
an update, but I'm not sure if its just that define thats out of date.
Care to give it a read through? 

		Dave

