Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSI2EHh>; Sun, 29 Sep 2002 00:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSI2EHh>; Sun, 29 Sep 2002 00:07:37 -0400
Received: from dp.samba.org ([66.70.73.150]:46217 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262385AbSI2EHh>;
	Sun, 29 Sep 2002 00:07:37 -0400
Date: Sun, 29 Sep 2002 14:11:29 +1000
From: Anton Blanchard <anton@samba.org>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] oprofile for 2.5.39
Message-ID: <20020929041129.GA29891@krispykreme>
References: <20020929014440.GA66796@compsoc.man.ac.uk.suse.lists.linux.kernel> <p737kh5sf45.fsf@oldwotan.suse.de> <20020929025224.GA68153@compsoc.man.ac.uk> <20020929050807.A17869@wotan.suse.de> <20020929032756.GA68826@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929032756.GA68826@compsoc.man.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [Are there any advantages to per_cpu stuff over hand-coding, other
> than readability ??]

As well as allocating the areas on separate cachelines and packing it
all together so you dont waste 1 cacheline minus a small amount times
NR_CPUS of memory, on NUMA boxes we will allocate the areas from local
memory.

Oh yeah we can also do some tricks to make the address generation
slightly quicker (eg we will probably dedicate r13 to be a pointer
to the start of the per cpu area on ppc64).

Anton
