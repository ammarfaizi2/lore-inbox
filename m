Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTAOE3a>; Tue, 14 Jan 2003 23:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAOE3a>; Tue, 14 Jan 2003 23:29:30 -0500
Received: from auto-matic.ca ([216.209.85.42]:19719 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261530AbTAOE33>;
	Tue, 14 Jan 2003 23:29:29 -0500
Date: Tue, 14 Jan 2003 23:46:44 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Bob Miller <rem@osdl.org>
Cc: DervishD <raul@pleyades.net>, Philippe Troin <phil@fifi.org>,
       root@chaos.analogic.com, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115044644.GA18608@mark.mielke.cc>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114231141.GC4603@doc.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 03:11:41PM -0800, Bob Miller wrote:
> On Tue, Jan 14, 2003 at 03:04:18PM -0800, Bob Miller wrote:
> > Or you can copy your all your args and env to a temporary place and
> > then re-build your args and env with the new argv[0] in it's place.
> > But you must be carefull that your new argv[0] length plus the 
> > length of all remaining args, envp and pointers is not greater than
> > the system defined size for this space.
> In thinking about this more this will NOT work.  The user stack starts
> right after your envp.  So, writing more info there would blow away
> your stack.

I can smell the next hack... memmove() the stack down to make room... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

