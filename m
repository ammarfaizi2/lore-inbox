Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289978AbSAPPaP>; Wed, 16 Jan 2002 10:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289975AbSAPPaE>; Wed, 16 Jan 2002 10:30:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25241 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289972AbSAPP35>;
	Wed, 16 Jan 2002 10:29:57 -0500
Date: Wed, 16 Jan 2002 10:29:54 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] zerocopy pipe, new version
Message-ID: <20020116102954.A1241@elinux01.watson.ibm.com>
In-Reply-To: <002701c19638$400f15f0$010411ac@local> <011001c19de8$ec1d4800$1cdb0209@diz.watson.ibm.com> <20020115145747.F6853@redhat.com> <001801c19e00$71c355a0$010411ac@local> <20020115152038.G6853@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115152038.G6853@redhat.com>; from bcrl@redhat.com on Tue, Jan 15, 2002 at 03:20:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 03:20:38PM -0500, Benjamin LaHaise wrote:
> On Tue, Jan 15, 2002 at 09:08:45PM +0100, Manfred Spraul wrote:
> > My patch is definitively WIP - right now I again broke the -ENOMEM and
> > -EFAULT handling.
> 
> I am aware of that, but the lse-tech posting made it sound as if things are 
> great now since the SMP numbers improved.  Please folks, remember that UP 
> numbers are important too.
> 
> 		-ben
> -- 
> Fish.

Ben, yes you are right, the lse-posting in a second reading is misleading.
As reported previously http://lse.sourceforge.net/pipe/pipe-report
UP numbers see degradations for LM-Bench, other benchmarks are OK.

This is not solved either by an integration of zero-copy with large pipes.
We have however shown that the for SMP systems adding larger pipes to
zero-copy pipes makes sense and for UP and 1-way sticking with a 1-page 
pipe does not degradate Manfred's patch.

It hence boils down to a proper parameterization of the pipe dependent on 
the configuration.

-- Hubertus 

