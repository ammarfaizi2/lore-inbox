Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933614AbWKQTsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614AbWKQTsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933620AbWKQTsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:48:21 -0500
Received: from nz-out-0102.google.com ([64.233.162.201]:54675 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933614AbWKQTsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:48:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nQJ6/XF9snIHHP3SwDDyB2B10QAbd9LTVTOrs3dOrgyjNGA1APvxpcQPmMMvGlP5YZl4b6PBtc3OnOLVDoVextTYoI4kM9GvMmexzVA76AE9C8O6vxmZ9c0PvbxLEnssswR5aXW9FQZCCTp24F14G4z6z+vxQLlEi/TTcYrcmjg=
Message-ID: <8aa016e10611171148r14d066a2q96fb17b91846396c@mail.gmail.com>
Date: Sat, 18 Nov 2006 01:18:19 +0530
From: "Dhaval Giani" <dhaval.giani@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: cpufreq userspace governor does not reflect changes
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <EB12A50964762B4D8111D55B764A8454E763B5@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <EB12A50964762B4D8111D55B764A8454E763B5@scsmsx413.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 11/18/06, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
>
> /sys/devices/....../cpuX/cpufreq/scaling_cur_freq
> Gives you the information about last frequency that Linux tried to set
> on this CPU
>
> /sys/devices/....../cpuX/cpufreq/cpuinfo_cur_freq
> (When supported) Gives you the information about actual frequency that
> the CPU is running at.
>
> Zero frequency value below is certainly a bug in the driver. What is the
> kernel you are using?

Ooops! sorry missed that one. Its the 2.6.19-rc5-mm2. Its having the
same .config which i posted on the bugzilla. Do you want the acpidump
again?

> On the particular CPU you have here, all cores in a package indeed share
> the frequency. But, it does not really show up in affected_cpus as OS is
> not coordinating the shared-ness of P-state across cores. That means, OS
> programs each core individually based on CPU utilization and hardware
> will pick the highest frequency among the two and run both cores at that
> frequency.
>

Hold on, so let me get it right. When i do an echo 1596000 >
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed, the cpu cores
will still be running at 1.86 Ghz since the other core is at that
frequency? In this situation how do I then change the frequency?

Thanks
Dhaval
