Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131908AbRBFABl>; Mon, 5 Feb 2001 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136046AbRBFABa>; Mon, 5 Feb 2001 19:01:30 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:530 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S131908AbRBFABP>;
	Mon, 5 Feb 2001 19:01:15 -0500
Date: Mon, 5 Feb 2001 22:01:09 -0200
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
Message-ID: <20010205220109.A9945@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de> <20010205013424.A15384@iname.com> <20010205144803.B5285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010205144803.B5285@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05 2001, Jens Axboe wrote:
> 	ioctl(cd_fd, CDROM_SELECT_SPEED, speed);

	I'd like to thank everybody that replied either on the list
	and privately. I didn't know that I could just use the /proc
	entries to change the IDE driver speed with a simple:

	echo current_speed:4 > /proc/ide/hdc/settings

	(Thanks Mark for this).

	I'd also like to thank Andries about the tip on the mount
	option. I didn't find anything in the util-linux (mount)
	manpage before I asked (I'm using Debian potato's util-linux
	2.10q-1).

	The option that I chose was to cook a little proggie to call
	the ioctl to set the speed. This is the most flexible solution
	(as it doesn't involve messing with fstab or being root to
	pass the mount option to mount). Thanks, Jens!

	Thank you all very, very much for the amazing (and fast) help!


	[]s, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
