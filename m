Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272066AbRHVSBG>; Wed, 22 Aug 2001 14:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272067AbRHVSA4>; Wed, 22 Aug 2001 14:00:56 -0400
Received: from web10902.mail.yahoo.com ([216.136.131.38]:46865 "HELO
	web10902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272066AbRHVSAl>; Wed, 22 Aug 2001 14:00:41 -0400
Message-ID: <20010822180056.58350.qmail@web10902.mail.yahoo.com>
Date: Wed, 22 Aug 2001 11:00:56 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: brlock_is_locked()?
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108221231260.19638-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1180809945-998503256=:57745"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1180809945-998503256=:57745
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

--- Ben LaHaise <bcrl@redhat.com> wrote:
> On Wed, 22 Aug 2001, Brad Chapman wrote:
> 
> > restart:
> > 	if (brlock_is_locked(BR_NETPROTO_LOCK)) {
> > 		CRITICAL_SECTION
> > 		br_write_unlock_bh(BR_NETPROTO_LOCK);
> > 	}
> > 	else {
> > 		/* Let's get dizzy */
> > 		br_write_lock_bh(BR_NETPROTO_LOCK);
> > 		goto restart;
> > 	}
> 
> That code can never work.  None of the linux spinlocks track ownership, so
> checking if a lock is locked tells you if your process or another has
> ownership of the lock.  The above pseudo code is going to result in lots
> of mangled data.
> 
> 		-ben
> 
Mr. LaHaise,

	Eeek! Sorry. What do you expect at 10:00 at night? ;-)

	I'm not talking about _who_ owns the lock, I'm talking about whether
the lock itself is locked. I don't care which process is using the lock;
I just want to know if _somebody_ is using it. Is this possible?

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net

Reply to the address I used in the message to you,
please!

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
--0-1180809945-998503256=:57745--
