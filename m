Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277130AbRJDFFJ>; Thu, 4 Oct 2001 01:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277131AbRJDFE7>; Thu, 4 Oct 2001 01:04:59 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:34323 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277130AbRJDFEm>; Thu, 4 Oct 2001 01:04:42 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Keith Owens <kaos@ocs.com.au>
Date: Thu, 4 Oct 2001 15:04:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15291.60903.127755.574686@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - gameport_{,un}register_port must be static when inline 
In-Reply-To: message from Keith Owens on Thursday October 4
In-Reply-To: <15291.58177.900493.276071@notabene.cse.unsw.edu.au>
	<11147.1002169889@kao2.melbourne.sgi.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 4, kaos@ocs.com.au wrote:
> On Thu, 4 Oct 2001 14:19:13 +1000 (EST), 
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >Linus,
> > 2.4.11-pre2 wont compile with some combinations of sound card drivers
> > if CONFIG_INPUT_GAMEPORT is not defined, as every driver than include
> > gameport.h causes "gameport_register_port" to be defined as a symbol
> > and there is a conflict.
> >
> > This patch makes the relevant inline functions "static" to avoid this
> > problem.
> 
> Please don't.  This was fixed in the -ac trees several weeks ago, the
> correct fix is to move the input rewrite from -ac to Linus's tree.
> That is up to the maintainer, Vojtech Pavlik.

Are you sure?  2.4.10 seems to have a big input rewrite, and
patch-2.4.10-ac4 doesn't change gameport.h and makes only minimal
changes to esssolo1.c, one of the drivers in question.

NeilBrown
