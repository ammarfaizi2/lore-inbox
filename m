Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSACA2I>; Wed, 2 Jan 2002 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288049AbSACARV>; Wed, 2 Jan 2002 19:17:21 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:55940
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288033AbSACAQU>; Wed, 2 Jan 2002 19:16:20 -0500
Date: Wed, 2 Jan 2002 17:16:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Richard Henderson <rth@redhat.com>, jtv <jtv@xs4all.nl>,
        Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103001605.GS1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl> <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103004514.B19933@xs4all.nl> <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102160739.A10659@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102160739.A10659@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 04:07:39PM -0800, Richard Henderson wrote:
> On Wed, Jan 02, 2002 at 05:01:18PM -0700, Tom Rini wrote:
> > Yes, but doesn't -ffreestanding imply that gcc _can't_ assume this is
> > the standard library...
> 
> Ignore strcpy.  Yes, that's what visibly causing a failure here,
> but the bug is in the funny pointer arithmetic.  Leave that in
> there and the compiler _will_ bite your ass sooner or later.

Er, which part of the 'funny pointer arithmetic' ?  I take it you aren't
a fan of the 'change to
memcpy(namep,RELOC("linux,phandle"),sizeof("linux,phandle"));' fix.
We need to do funny things here, and thus need a way to tell gcc to just
do what we're saying.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
