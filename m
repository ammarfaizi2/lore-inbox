Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129405AbQKFI4A>; Mon, 6 Nov 2000 03:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130350AbQKFIzu>; Mon, 6 Nov 2000 03:55:50 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:60171 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129405AbQKFIzg>; Mon, 6 Nov 2000 03:55:36 -0500
Date: Mon, 6 Nov 2000 10:05:49 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Looking for better VM
Message-ID: <Pine.LNX.4.21.0011060854110.1242-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Nov 2000, Rik van Riel wrote:

> I'm definately looking forward to an "OOM killer showdown" 
> where we can compare how the different OOM tactics work.

Since people must live with Linux's overcommiting feature the winner
would be the one that could be tuned runtime. The best general purpuse
killer could be set as default. OOM-Killer-API-Patch is a really long
waited promising 1st step.

Please also consider to give Linux application developers a chance to
be able to write reliable software and not to kill the app with the
same possibility as the apps that ask for more memory constantly in
the long run (i.e. they don't touch the mem they requested, don't have
own mem handling, etc). 

> Not because I think it matters all that much on most systems 
> (good admins put in enough memory&swap), 

Good admins can not put in enough memory&swap because Linux overcommit
memory, they can put extra memory&swap to a non-overcommiting system
(Solaris, Tru64, Irix, NetBSD, etc - usually they also support
non-overcommit) at an average additional 5-10% cost to achive the same
workload as Linux and they can login in and kill the offending
processes if system is out of user memory [falling back to process
killing if memory reserved for root is also out -- but this basically
never happens compared to the frequent crash complaints in case of
Linux]. A Linux admin can setup mem quotas that's in average more
expensive [see, (almost?) all Linux distribution comes with a default
config that can be easily crashed by any user] than buying cheap extra
disk/RAM and using non-overcommit VM handling (at least the default
setup can't be crashed by a user) or the Linux admin can pray or hope
some black magic that seems to be a very often case and in the end
result disappointment and anger.

> but simply because 
> it appears there has been amazingly little research on this 
> subject and it's completely unknown which approach will work 

There has been lot of research, this is the reason most Unices support
both non-overcommit and overcommit memory handling default to
non-overcommit [think of reliability and high availability].

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
