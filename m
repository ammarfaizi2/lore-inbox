Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272340AbRH3RCX>; Thu, 30 Aug 2001 13:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272341AbRH3RCO>; Thu, 30 Aug 2001 13:02:14 -0400
Received: from smtp5.us.dell.com ([143.166.83.100]:27657 "EHLO
	smtp5.us.dell.com") by vger.kernel.org with ESMTP
	id <S272340AbRH3RB4>; Thu, 30 Aug 2001 13:01:56 -0400
Date: Thu, 30 Aug 2001 12:02:13 -0500 (CDT)
From: Michael E Brown <michael_e_brown@dell.com>
X-X-Sender: <mebrown@blap.linuxdev.us.dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
In-Reply-To: <Pine.LNX.4.33.0108301247130.12593-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0108301150460.1213-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And your response to the rest of the points I raised would be?

I'm sorry about e2fsprogs. If I had known a bit better (this was my first
kernel patch), I would have added a magic number to the struct you pass
in, and that would have prevented this little bit of braindamage.
--
Michael

On Thu, 30 Aug 2001, Ben LaHaise wrote:

> On Thu, 30 Aug 2001, Michael E Brown wrote:
>
> > And your last point about risking unexpected disk-io due to an incorrect
> > IOCTL, I would say that is a pretty unlikely in practice. First, I do
> > parameter checking on what was passed to the IOCTL, and if things don't
> > match, no io is done. Second, how likely is it that you a) call ioctl with
> > a (disk) block device, b) pass the wrong ioctl, c) pass along enough data
> > to pass the checks in the ioctl, and d) pass along a valid pointer to 512
> > bytes of data to overwrite something?
>
> e2fsprogs-1.23 on x86 does this.
>
> 		-ben
>
>

-- 
Michael Brown
Linux OS Development
Dell Computer Corp

  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.


