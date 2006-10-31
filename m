Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423242AbWJaN1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423242AbWJaN1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423243AbWJaN1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:27:08 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:44459 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423242AbWJaN1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:27:05 -0500
Date: Tue, 31 Oct 2006 19:01:49 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       Paul Jackson <pj@sgi.com>, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061031133149.GC9588@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com> <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com> <20061031115342.GB9588@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031115342.GB9588@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:23:43PM +0530, Srivatsa Vaddagiri wrote:
> 	mount -t container -ocpu container /dev/cpu
> 
> 		-> Represents a hierarchy for cpu control purpose.
> 
> 		   tsk->cpurc	= represent the node in the cpu
> 				  controller hierarchy. Also maintains 
> 				  resource allocation information for
> 				  this node.

I suspect this will lead to code like:

	if (something->..->options == cpu)
		tsk->cpurc = ..
	else if (something->..->options == mem)
		tsk->memrc = ..

Dont know enough of filesystems atm to say if such code is avoidable.



-- 
Regards,
vatsa
