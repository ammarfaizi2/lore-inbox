Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWAJOEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWAJOEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAJOEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:04:47 -0500
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:27082 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S932114AbWAJOEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:04:46 -0500
Message-ID: <43C3BF00.9000901@stud.feec.vutbr.cz>
Date: Tue, 10 Jan 2006 15:04:48 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Knecht <markknecht@gmail.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>	 <43C17E50.4060404@stud.feec.vutbr.cz>	 <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr>	 <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>	 <20060110100517.GA23255@elte.hu>	 <1136900950.6197.33.camel@localhost.localdomain> <5bdc1c8b0601100555k7538924cx7a17b3e405771691@mail.gmail.com>
In-Reply-To: <5bdc1c8b0601100555k7538924cx7a17b3e405771691@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Knecht wrote:
>    While I have to agree that *if* cdrecord is running at a higher
> priority then Jack would get trumped, I'm not positive yet that we
> know that's true in this specific case. I have not yet received any
> response from the developer of k3b, and while cdrecord is listed in
> the setup of k3b I'm not sure how to test that it is really causing
> the specific failure I saw.

That shouldn't be too hard. While burning a CD, see the priority 
cdrecord is running at. You can use:
ps -eo pid,user,args,pri | grep cdrecord

Also see if you have cdrecord installed suid root:
ls -l `which cdrecord`
If you do, you can be pretty sure that it runs at the highest possible 
realtime priority. This is hardcoded in cdrecord. It does it if it runs 
priviledged.

Michal

