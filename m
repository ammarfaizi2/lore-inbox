Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288064AbSACAWP>; Wed, 2 Jan 2002 19:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288057AbSACAUa>; Wed, 2 Jan 2002 19:20:30 -0500
Received: from mxzilla4.xs4all.nl ([194.109.6.48]:55816 "EHLO
	mxzilla4.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288067AbSACATH>; Wed, 2 Jan 2002 19:19:07 -0500
Date: Thu, 3 Jan 2002 01:19:05 +0100
From: jtv <jtv@xs4all.nl>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, paulus@samba.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103011905.D19933@xs4all.nl>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <15411.37817.753683.914033@argo.ozlabs.ibm.com> <877kr0uyc5.fsf@fadata.bg> <20020102233452.GQ1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020102233452.GQ1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 04:34:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 04:34:52PM -0700, Tom Rini wrote:
> On Thu, Jan 03, 2002 at 01:28:42AM +0200, Momchil Velikov wrote:
> > 
> > GCC thinks exactly what the function does.
> 
> And then optimizes it to something that fails to work in this particular
> case.

Which it may do with another function *or expression* as well, because
the real bug has already happened before the function call comes into
the issue.

As far as I'm concerned the options are: fix RELOC; obviate RELOC; use
an appropriate gcc option if available (-fPIC might be it, -ffreestanding
certainly isn't--see above); *extend* (not fix, extend) gcc; or work
around all individual cases.  In rough descending order of preference.


Jeroen

