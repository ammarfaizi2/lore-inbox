Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291813AbSBHVMp>; Fri, 8 Feb 2002 16:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291826AbSBHVMh>; Fri, 8 Feb 2002 16:12:37 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52982
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291834AbSBHVMV>; Fri, 8 Feb 2002 16:12:21 -0500
Date: Fri, 8 Feb 2002 13:12:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] larger kernel stack (8k->16k) per task
Message-ID: <20020208211221.GB343@mis-mike-wstn>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081645170.1359-100000@einstein.homenet> <d3eljvlo5u.fsf@lxplus052.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3eljvlo5u.fsf@lxplus052.cern.ch>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 09:22:05PM +0100, Jes Sorensen wrote:
> Tigran Aivazian <tigran@veritas.com> writes:
> 
> > So, I found this patch useful at least for debugging. Moreover, I think it
> > would be very useful to have it in Linus' kernel as a CONFIG_ option so
> > that if people complain about random memory corruption then they can try
> > to reproduce it with larger stack and then (with aid of /proc/stack) the
> > offender is found and fixed. I cc'd Alan; if he thinks this is a bad idea
> > I would be interested to know why.
> 
> Well as someone suggested, stick it under CONFIG_SLAB_DEBUG then, it

That was suggested by Andrew Morton...

> surely shouldn't be an option to be enabled in normal production
> kernels but for debugging it's fine.
> 

Ahh, but if you are overflowing the stack by a few bytes, and then enable
stack debugging the error will go away because of the alrger stack.

If this goes in, it should have its own config option.

Mike
