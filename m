Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbTCJNKN>; Mon, 10 Mar 2003 08:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbTCJNKN>; Mon, 10 Mar 2003 08:10:13 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:25570 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261309AbTCJNKM>; Mon, 10 Mar 2003 08:10:12 -0500
Date: Mon, 10 Mar 2003 14:14:22 +0100
From: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Arun Prasad <arun@netlab.hcltech.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: 2.5.51 CRC32 undefined
Message-ID: <20030310131422.GA525@wohnheim.fh-wedel.de>
References: <1047040816.32200.59.camel@passion.cambridge.redhat.com> <Pine.LNX.4.44.0303070922580.26430-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0303070922580.26430-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 March 2003 09:27:07 -0600, Kai Germaschewski wrote:
> On 7 Mar 2003, David Woodhouse wrote:
> 
> > The problem is that crc32.o isn't actually linked into the kernel,
> > because no symbols from it are referenced when the linker is asked to
> > pull in lib/lib.a
> > 
> > Set CONFIG_CRC32=m. We probably shouldn't allow it to be set to 'Y' in
> > the first place., given the above.
> 
> I think it'd be much nicer to just make it work, which can easily be done 
> by moving the EXPORT_SYMBOL() to kernel/ksyms.c. Or, just move the entire 
> file into kernel/ (which unfortunately isn't a very natural place for it. 
> The real problem is that we need a lib/dont_drop_unreferenced/)

Is it just me, or does lib/lib._a_ not make too much sense? It is nice
to be speaking about the kernel library, but what are the benefits of
it being a .a instead of a .o?

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979
