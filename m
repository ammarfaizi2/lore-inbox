Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUJHOZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUJHOZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269801AbUJHOZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:25:57 -0400
Received: from jade.aracnet.com ([216.99.193.136]:39326 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268185AbUJHOZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:25:55 -0400
Date: Fri, 08 Oct 2004 07:24:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>
cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <1382270000.1097245476@[10.10.2.4]>
In-Reply-To: <200410081123.45762.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20041007105425.02e26dd8.pj@sgi.com> <1344740000.1097172805@[10.10.2.4]> <200410081123.45762.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 07 October 2004 20:13, Martin J. Bligh wrote:
>> It all just seems like a lot of complexity for a fairly obscure set of
>> requirements for a very limited group of users, to be honest. Some bits
>> (eg partitioning system resources hard in exclusive sets) would seem likely
>> to be used by a much broader audience, and thus are rather more attractive.
> 
> May I translate the first sentence to: the requirements and usage
> models described by Paul (SGI), Simon (Bull) and myself (NEC) are
> "fairly obscure" and the group of users addressed (those mainly
> running high performance computing (AKA HPC) applications) is "very
> limited"? If this is what you want to say then it's you whose view is
> very limited. Maybe I'm wrong with what you really wanted to say but I
> remember similar arguing from your side when discussing benchmark
> results in the context of the node affine scheduler.

No, I was talking about the non-exclusive part of cpusets that wouldn't
fit inside another mechanism. The basic partitioning I have no problem
with, and that seemed to cover most of the requirements, AFAICS.

As I've said before, the exclusive stuff makes sense, and is useful to
a wider audience, I think. Having non-exclusive stuff whilst still 
requiring physical partioning is what I think is obscure, won't work
well (cpus_allowed is problematic) and could be done in userspace anyway.

M.
