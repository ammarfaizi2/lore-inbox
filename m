Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318875AbSICQ3F>; Tue, 3 Sep 2002 12:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318876AbSICQ3F>; Tue, 3 Sep 2002 12:29:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53263 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318875AbSICQ3D>; Tue, 3 Sep 2002 12:29:03 -0400
Date: Tue, 3 Sep 2002 13:33:20 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: root@chaos.analogic.com, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <200209031629.g83GT2e08075@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44L.0209031331360.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> > How does the other user's of this device "know" that there is
> > a new file so it can update its notion of the block-device state?
>
> The block device itself is stateless at the block level. Every block
> access goes "direct to the metal".
>
> The question is how much FS state is cached on either kernel.
> If it is too much, then I will ask how I can cause to be less, perhaps
> by use of a flag that parallels how O_DIRECT works.  I thought that new
> files were entries in a directories inode and I agree that inodes are
> held in memory!  But I don't know when they are first read or reread.

And neither can you know.  After all, this is filesystem dependant.

You cannot decide whether filesystem-independant clustering is
possible unless you know that all the filesystems play by your
rules.  So much for filesystem-independance.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

