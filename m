Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315790AbSENQCh>; Tue, 14 May 2002 12:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315792AbSENQCg>; Tue, 14 May 2002 12:02:36 -0400
Received: from mark.mielke.cc ([216.209.85.42]:40969 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S315790AbSENQCf>;
	Tue, 14 May 2002 12:02:35 -0400
Date: Tue, 14 May 2002 11:56:55 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020514115655.A22935@mark.mielke.cc>
In-Reply-To: <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl> <3CE1300A.990919E2@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) You can always submit a patch, and see whether other people approve of it.

2) If you won't do it, why would somebody else working on something that
   provides lower latency to user process response time, or improvement
   to the IDE drivers, take the time to deal with this issue?

You need to either do 1), or convince somebody to do 2).

As it is, there are plenty of other denial-of-service type attacks
that can be performed that would be more effective than the 'exploit'
you have mentioned. Your proposal would need to be 'fix them all', if
your complaint is that Linux has a security hole.

If you complaint is that an administrator might mistakenly believe
that it is a security feature, I suggest your understand that this is
merely one issue of quite a few. If the administrator is not aware of
issues such as these, perhaps they should not be an administrator?

mark


On Tue, May 14, 2002 at 05:40:58PM +0200, Kasper Dupont wrote:
> Horst von Brand wrote:
> > 
> > Elladan <elladan@eskimo.com> said:
> > 
> > [...]
> > 
> > > Regardless of whether it's a good thing to depend on security-wise, it
> > > is a problem to have something that appears to be a security feature
> > > which doesn't actually work.
> > 
> > It is _not_ a security feature, it is meant to keep the filesystem from
> > fragmenting too badly. root can use that space, since root can do whatever
> > she wants anyway.
> 
> My point was that anybody can use this space if they want to.
> 
> While this feature might not be intended to be used for
> security purposes, the documentation says the space is
> reserved for the super-user. And in many cases it would be
> convenient to use the feature for that purpose.
> 
> Since this would be a usefull feature for many people, and
> since it AFAIK cannot be acomplished with quotas, I suggest
> we find a way to make it work like most people would expect.
> 
> Would it cause any problems if the kernel ensured that the
> block reservations could not be bypassed by users?
> 
> I have not yet verified if the same problem exists when
> using quotas. (My kernel is compiled without quotas). But
> if it does I guess we all would like to have it fixed.
> 
> -- 
> Kasper Dupont -- der bruger for meget tid på usenet.
> For sending spam use mailto:razor-report@daimi.au.dk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

