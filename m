Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTAPAN3>; Wed, 15 Jan 2003 19:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbTAPAN3>; Wed, 15 Jan 2003 19:13:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5941 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266932AbTAPAN1>; Wed, 15 Jan 2003 19:13:27 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: davidm@hpl.hp.com, Sam Ravnborg <sam@ravnborg.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
References: <Pine.LNX.4.44.0301151638240.24883-100000@chaos.physics.uiowa.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jan 2003 17:19:38 -0700
In-Reply-To: <Pine.LNX.4.44.0301151638240.24883-100000@chaos.physics.uiowa.edu>
Message-ID: <m1iswqeyjp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:

> On Mon, 13 Jan 2003, David Mosberger wrote:
> 
> > 
> >   Kai> I would suggest an approach like the following, of course
> >   Kai> showing only a first simple step. A series of steps like this
> >   Kai> should allow for a serious reduction in size of
> >   Kai> arch/*/vmlinux.lds.S already, while being obviously correct and
> >   Kai> allowing archs to do their own special thing if necessary (in
> >   Kai> particular, IA64 seems to differ from all the other archs).
> > 
> > The only real difference for the ia64 vmlinux.lds.S is that it
> > generates correct physical addressess, so that the boot loader doesn't
> > have to know anything about the virtual layout of the kernel.
> > Something that might be useful for other arches as well...
> 
> I just found another way of changing the LMA in vmlinux, which is far 
> less intrusive than what IA-64 uses. Do you see any reason why something 
> like the following patch (which changes the LMA for i386) wouldn't work 
> for IA-64?

Be very careful.  There are some versions of ld (I forget which)
that do not behave correctly when PHDRS are used.

Eric
