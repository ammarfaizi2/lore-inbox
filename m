Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287141AbSABWue>; Wed, 2 Jan 2002 17:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287145AbSABWuS>; Wed, 2 Jan 2002 17:50:18 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:56963
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287179AbSABWuG>; Wed, 2 Jan 2002 17:50:06 -0500
Date: Wed, 2 Jan 2002 15:50:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Richard Henderson <rth@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102225004.GN1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102142712.B10474@redhat.com> <20020102223557.GM1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102144435.A10500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102144435.A10500@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 02:44:35PM -0800, Richard Henderson wrote:
> On Wed, Jan 02, 2002 at 03:35:57PM -0700, Tom Rini wrote:
> > That's not really an option.
> 
> Oh come on.  It shouldn't take very much code at all to properly
> relocate the binary.  You can use either -fpic or -mrelocatable
> to get hold of the set of addresses in question.

Have you looked at all of the code in question?  We're doing a lot of things
before we properly relocate ourself.  And as long as things aren't being
optimized away, it just works.

And the other thing is if we want gcc-3.0 to produce a good kernel on
PPC in 2.4.x, the kernel-side changes should be as minimal as possible.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
