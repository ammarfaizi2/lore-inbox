Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbRFQTis>; Sun, 17 Jun 2001 15:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRFQTij>; Sun, 17 Jun 2001 15:38:39 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:3200 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S262694AbRFQTie>;
	Sun, 17 Jun 2001 15:38:34 -0400
Date: Sun, 17 Jun 2001 22:40:15 +0300
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Client receives TCP packets but does not ACK
Message-ID: <20010617224015.A8341@spiral.extreme.ro>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <03c701c0f5c8$e15f7e10$e1de11cc@csihq.com> <E15Az1U-0006wI-00@the-village.bc.nu> <20010617201727.A1493@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010617201727.A1493@bug.ucw.cz>; from pavel@suse.cz on Sun, Jun 17, 2001 at 08:17:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 08:17:27PM +0200, Pavel Machek wrote:

> > 2.	There is a flaw in the TCP protocol itself that is extremely unlikely
> > 	to bite people but can in theory cause wrong data in some unusual
> > 	circumstances that Ian Heavans found and has yet to be fixed by
> > 	the keepers of the protocol.

Bit offtopic.

Is there any logical reason why if, given fd is a connected, AF_INET,
SOCK_STREAM socket, and one does a write(fd, buffer, len); close(fd);
to the peer, over a rather slow network (read modem, satelite link, etc),
the data gets lost (the remote receives the disconnect before the last
packet). According to socket(7), even if SO_LINGER is not set, the data
is flushed in the background.

Is it Linux or TCP specific? Or some obvious techincal detail I'm missing?

Thanks, Dan.
