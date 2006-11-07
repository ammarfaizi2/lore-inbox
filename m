Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWKGNVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWKGNVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWKGNVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:21:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:29380 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932615AbWKGNVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:21:16 -0500
Date: Tue, 7 Nov 2006 18:50:14 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul Menage" <menage@google.com>
Cc: "Paul Jackson" <pj@sgi.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061107132014.GA21811@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com> <20061031115342.GB9588@in.ibm.com> <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com> <20061101172540.GA8904@in.ibm.com> <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com> <20061106124948.GA3027@in.ibm.com> <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 12:23:44PM -0800, Paul Menage wrote:
> In practice though, do you think the admin would really want to be
> have to move individual processes around by hand? Sure, it's possible,
> but wouldn't it make more sense to just give the entire student/www
> class more network bandwidth? Or more generically, how often are

Wouldn't that cause -all- browsers to get enhanced network access? This
is when your intention was to give one particular student's browser
enhanced network access (to do online gaming) while retaining its
existing cpu/mem/io limits or another particular students simulation app 
enhanced CPU access while retaining existing mem/io limits.

> people going to be needing to move individual processes from one QoS
> class to another, rather than changing the QoS for the existing class?

If we are talking of tasks moving from one QoS class to another, then it
can be pretty frequent in case of threaded databases and webservers.
I have been told that, atleast in case of databases, depending on the
workload, tasks may migrate from one group to another on every request.
In general, duration of requests fall within the milliseconds to seconds
range. So, IMO, design should support frequent task-migration.

Also, the requirement to tune individual resource availability for
specific apps/processes (ex: boost its CPU usage but retain other existing
limits) may not be unrealistic.

-- 
Regards,
vatsa
