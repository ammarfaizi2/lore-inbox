Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWITXy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWITXy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWITXy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:54:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53142 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750790AbWITXy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:54:26 -0400
Date: Wed, 20 Sep 2006 16:54:08 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: npiggin@suse.de, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920165408.c10e8857.pj@sgi.com>
In-Reply-To: <6599ad830609201605s2fc1ccbdse31e3e60a50d56bc@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	<1158778496.6536.95.camel@linuxchandra>
	<6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	<20060920134903.fbd9fea8.pj@sgi.com>
	<6599ad830609201351k6d72067fpc86069ffb5bb60ba@mail.google.com>
	<20060920140401.39cc88ab.pj@sgi.com>
	<6599ad830609201605s2fc1ccbdse31e3e60a50d56bc@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M. wrote:
> idea of separation between the container aspects of cpusets (which are
> almost identical to the container aspects of resource groups) and the
> resource control portions. Essentially, I've
> 
> - ripped out the cpusetfs portions of cpusets and moved them to container.c

There may be an opportunity here, I agree.  Sorry for not realizing
what you were getting at before.

I might not have time to study the details of this yet, and may wait
until it is a bit clearer to me which other resource/container/grouping
thingies are closer to final acceptance, but there are a few neurons
off in one corner of my brain that have long suspected that a single
chunk of kernel pseudo file system code, layered on vfs, should serve
these various mechanisms, including cpusets.  It would be good to
persue this common technology infrastructure -before- the kernel to
user API of these other thingies gets frozen, as the details of just
what this common code can do conveniently might impact details of the
kernel API presented to users.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
