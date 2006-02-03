Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWBCStN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWBCStN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWBCStN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:49:13 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:28736 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422631AbWBCStM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:49:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=njqZreobAJSlLmJBdyMDrfWOnBbxPEeWlsfEdjXHgmnlarAkr1MC/oT6+jC6oXohncGeFKzT3nmuwhtN40cY60lqbl0YH7QDH958nirWl1Je5nHe1MRnN2s/1yFp37Hf3PBeFXukkmVwWsIYLOjYsTthRmexuKGhSQjm7/Z/g+I=
Message-ID: <79052f10602031049m4dfdab3cyce643db486483b70@mail.gmail.com>
Date: Fri, 3 Feb 2006 19:49:10 +0100
From: Andreas Eriksson <andreas@tpwch.com>
To: linux-kernel@vger.kernel.org
Subject: can't enable cpufreq ondemand governor
In-Reply-To: <79052f10602031042p9c5a3d9xf3934a2f0a3073bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <79052f10602031042p9c5a3d9xf3934a2f0a3073bf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernels I have tried it with are 2.6.15-1-686 and 2.6.15-ck3 and
2.6.15 vanilla, and this happens with all of those.
When I try to enable the ondemand or the conservative governors it
gives an error message:

 # pwd
/sys/devices/system/cpu/cpu0/cpufreq
# cat scaling_available_governors
userspace conservative ondemand performance
# echo performance > scaling_governor
# echo userspace > scaling_governor
 # echo ondemand > scaling_governor
bash: echo: write error: invalid argument
# echo conservative > scaling_governor
bash: echo: write error: invalid argument
# cat scaling_governor
userspace

 Here is some info about my system, tell me if you need more:
IBM Thinkpad R40 Laptop
Debian Sid updated yesterday
Pentium 4 2ghz

# lsmod | grep cpu
cpufreq_userspace       4216  1
cpufreq_conservative     6692  0
cpufreq_ondemand        5820  0
# lsmod | grep speed
speedstep_ich           4844  0
speedstep_lib           3972  1 speedstep_ich
freq_table              4164  1 speedstep_ich

Using powernowd with the userspace governor works fine.
Please cc any replies to me since I'm not subscribed to the list.

--
Andreas Eriksson (TPC)
