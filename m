Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288063AbSACAch>; Wed, 2 Jan 2002 19:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288082AbSACAbN>; Wed, 2 Jan 2002 19:31:13 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:645 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288067AbSACA3m>; Wed, 2 Jan 2002 19:29:42 -0500
Date: Wed, 2 Jan 2002 17:29:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: jtv <jtv@xs4all.nl>
Cc: Momchil Velikov <velco@fadata.bg>, paulus@samba.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103002935.GT1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <15411.37817.753683.914033@argo.ozlabs.ibm.com> <877kr0uyc5.fsf@fadata.bg> <20020102233452.GQ1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103011905.D19933@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103011905.D19933@xs4all.nl>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 01:19:05AM +0100, jtv wrote:
> On Wed, Jan 02, 2002 at 04:34:52PM -0700, Tom Rini wrote:
> > On Thu, Jan 03, 2002 at 01:28:42AM +0200, Momchil Velikov wrote:
> > > 
> > > GCC thinks exactly what the function does.
> > 
> > And then optimizes it to something that fails to work in this particular
> > case.
> 
> Which it may do with another function *or expression* as well, because
> the real bug has already happened before the function call comes into
> the issue.

What's the bug?  The 'funny' arithmetic?

> As far as I'm concerned the options are: fix RELOC;

How?

> obviate RELOC; use
> an appropriate gcc option if available (-fPIC might be it, -ffreestanding
> certainly isn't--see above);

Maybe for 2.5.  Too invasive for 2.4.x (initially at least).

> *extend* (not fix, extend) gcc; or work
> around all individual cases.  In rough descending order of preference.

Er, say what?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
