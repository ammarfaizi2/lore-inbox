Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265156AbRFZXrC>; Tue, 26 Jun 2001 19:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265157AbRFZXqn>; Tue, 26 Jun 2001 19:46:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:20494 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265156AbRFZXqa>; Tue, 26 Jun 2001 19:46:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] User chroot
Date: 26 Jun 2001 16:46:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9hb6rq$49j$1@cesium.transmeta.com>
In-Reply-To: <20010627014534.B2654@ondska>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010627014534.B2654@ondska>
By author:    Jorgen Cederlof <jc@lysator.liu.se>
In newsgroup: linux.dev.kernel
> 
> Have you ever wondered why normal users are not allowed to chroot?
> 
> I have. The reasons I can figure out are:
> 
> * Changing root makes it trivial to trick suid/sgid binaries to do
>   nasty things.
> 
> * If root calls chroot and changes uid, he expects that the process
>   can not escape to the old root by calling chroot again.
> 
> If we only allow user chroots for processes that have never been
> chrooted before, and if the suid/sgid bits won't have any effect under
> the new root, it should be perfectly safe to allow any user to chroot.
> 

Safe, perhaps, but also completely useless: there is no way the user
can set up a functional environment inside the chroot.  In other
words, it's all pain, no gain.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
