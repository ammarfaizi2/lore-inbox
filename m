Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269647AbUJFX4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269647AbUJFX4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269633AbUJFXZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:25:01 -0400
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:35298 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S269620AbUJFXXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:23:10 -0400
Message-ID: <41647E59.9080700@bigpond.net.au>
Date: Thu, 07 Oct 2004 09:23:05 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Simon.Derr@bull.net, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <835810000.1096848156@[10.10.2.4]> <20041003175309.6b02b5c6.pj@sgi.com> <838090000.1096862199@[10.10.2.4]> <20041003212452.1a15a49a.pj@sgi.com> <843670000.1096902220@[10.10.2.4]> <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr> <58780000.1097004886@flay> <20041005172808.64d3cc2b.pj@sgi.com> <1193270000.1097025361@[10.10.2.4]> <20041005190852.7b1fd5b5.pj@sgi.com> <1097103580.4907.84.camel@arrakis>
In-Reply-To: <1097103580.4907.84.camel@arrakis>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> On Tue, 2004-10-05 at 19:08, Paul Jackson wrote:
> 
> I don't know that these partitions would necessarily need their own
> scheduler, allocator and resource manager, or if we would just make the
> current scheduler, allocator and resource manager aware of these
> boundaries.  In either case, that is an implementation detail not to be
> agonized over now.

It's not so much whether they NEED their own scheduler, etc. as whether 
it should be possible for them to have their own scheduler, etc.  With a 
configurable scheduler (such as ZAPHOD) this could just be a matter of 
having separate configuration variables for each cpuset (e.g. if a 
cpuset has been created to contain as bunch of servers there's no need 
to try and provide good interactive response for its tasks (as none of 
them will be interactive) so the interactive response mechanism can be 
turned off in that cpuset leading to better server response and throughput).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
