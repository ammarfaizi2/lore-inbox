Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUJFBRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUJFBRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUJFBRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:17:33 -0400
Received: from jade.aracnet.com ([216.99.193.136]:17103 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266611AbUJFBRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:17:30 -0400
Date: Tue, 05 Oct 2004 18:16:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: Simon.Derr@bull.net, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <1193270000.1097025361@[10.10.2.4]>
In-Reply-To: <20041005172808.64d3cc2b.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]><200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]><20041003083936.7c844ec3.pj@sgi.com><834330000.1096847619@[10.10.2.4]><835810000.1096848156@[10.10.2.4]><20041003175309.6b02b5c6.pj@sgi.com><838090000.1096862199@[10.10.2.4]><20041003212452.1a15a49a.pj@sgi.com><843670000.1096902220@[10.10.2.4]><Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
 <58780000.1097004886@flay> <20041005172808.64d3cc2b.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  1) Are you going to prevent sched_setaffinity calls as well?

Outside of the the exclusive domain they're bound into, yes.

>     What about the per-cpu kernel threads?

Those are set up before the userspace domains, so will fall into
whatever domain they're bound to.

<cut lots of other stuff ...>

I think we're now getting down into really obscure requirements for
particular types of wierd MP jobs. Whether Linux wants to support that
or not is open to debate, but personally, given the complexity involved,
I'd be against it.

I agree with the basic partitioning stuff - and see a need for that. The
non-exclusive stuff I think is fairly obscure, and unnecessary complexity
at this point, as 90% of it is covered by CKRM. It's Andrew and Linus's 
decision, but that's my input.

We'll never be able to provide every single feature everyone wants without
overloading the kernel with reams of complexity. It's also an evolutionary
process of putting in the most important stuff first, and seeing how it
goes. I see that as the exclusive domain stuff (when we find a better
implementation than cpus_allowed) + the CKRM scheduling resource control.
I know you have other opinions.

M.

