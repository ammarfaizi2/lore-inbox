Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288007AbSAHM6Y>; Tue, 8 Jan 2002 07:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288001AbSAHM6O>; Tue, 8 Jan 2002 07:58:14 -0500
Received: from mxzilla4.xs4all.nl ([194.109.6.48]:45573 "EHLO
	mxzilla4.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288007AbSAHM6I>; Tue, 8 Jan 2002 07:58:08 -0500
Date: Tue, 8 Jan 2002 13:58:06 +0100
From: jtv <jtv@xs4all.nl>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Tim Hollebeek <tim@hollebeek.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020108135806.I11855@xs4all.nl>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E402@IIS000> <20020107224907.D8157@xs4all.nl> <20020107172832.A1728@cj44686-b.reston1.va.home.com> <20020107231620.H8157@xs4all.nl> <20020108012734.E23665@werewolf.able.es> <20020108124151.E11855@xs4all.nl> <ory9j9uihs.fsf@free.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ory9j9uihs.fsf@free.redhat.lsd.ic.unicamp.br>; from aoliva@redhat.com on Tue, Jan 08, 2002 at 10:36:47AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 10:36:47AM -0200, Alexandre Oliva wrote:
> 
> > Yes, thank you, that part was obvious already.  The question pertained
> > to the fact that nobody outside compiler-visible code was being handed
> > an address for b, and so the compiler could (if it wanted to) prove
> > under pretty broad assumptions that nobody could *find* b to make the
> > change in the first place.
> 
> How about a debugger?

True.  I just figured that actually modifying auto variables that were
assigned only once and used only once in a debugger fell under the heading
of *very* broad assumptions.  :-)

As it turns out, the discussion is now moot since volatile does indeed
imply here what I dared not assume it would, and so it might even solve
the RELOC problem.


Jeroen

