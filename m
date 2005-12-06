Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVLFU1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVLFU1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVLFU1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:27:20 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7908 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030222AbVLFU1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:27:19 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Brian Gerst <bgerst@didntduck.org>,
       Arjan van de Ven <arjan@infradead.org>, "M." <vo.sinh@gmail.com>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1133898911.29084.25.camel@mindpipe>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
	 <20051206030828.GA823@opteron.random>
	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>
	 <1133869465.4836.11.camel@laptopd505.fenrus.org>
	 <4394ECA7.80808@didntduck.org>  <4395E2F4.7000308@pobox.com>
	 <1133897867.29084.14.camel@mindpipe>  <4395E962.2060309@pobox.com>
	 <1133898911.29084.25.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 20:25:35 +0000
Message-Id: <1133900736.23610.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-06 at 14:55 -0500, Lee Revell wrote:
> > It's still legally shaky.  The "Chinese wall" approach I described above 
> > is beyond reproach, and that's where Linux needs to be.
> 
> I know you are not a lawyer but do you have a pointer or two?  As long
> as we are REing for interoperability I've never read anything to
> indicate the approach I described could be a problem even in the US.

It isnt a problem providing you don't copy anything. The chinese wall
approach is used to avoid the risk that what happens is not 

"Oh so register foo bit 4 controls the backlight"


but

"this sequence of instructions turns on the backlight"


The risk is that by reading the disassembled binary and rewriting it a
programming might actually be deemed to have copied code if they
accidentally just reproduce the original implementation.


Often of course disassembly is the hard way to solve the problem. Firing
up the driver with analyser tools and studying how it works can be far
more informative. With the ATI R3xx work asking the binary driver to
draw a wide range of triangles and monitoring the command queue output
for each request  provides very good info, while attempting to deciphers
megabytes of windows 3D driver code, which is likely to contain self
modifying or JIT generated pipelines, is going to be extremely hard
work.


