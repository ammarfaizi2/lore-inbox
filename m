Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZBJG>; Thu, 25 Jan 2001 20:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130355AbRAZBI7>; Thu, 25 Jan 2001 20:08:59 -0500
Received: from gatekeeper.gozer.weebeastie.net ([61.8.7.91]:41732 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129169AbRAZBIu>; Thu, 25 Jan 2001 20:08:50 -0500
Date: Fri, 26 Jan 2001 12:08:31 +1100
From: CaT <cat@zip.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
Message-ID: <20010126120831.D366@zip.com.au>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net> <200101251905.f0PJ5ZG216578@saturn.cs.uml.edu> <14960.31423.938042.486045@pizda.ninka.net> <20010125115214.D9992@draco.foogod.com> <m3itn3i5iu.fsf@austin.jhcloos.com> <14960.50897.494908.316057@pizda.ninka.net> <20010126115057.A366@zip.com.au> <14960.52503.383968.366586@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14960.52503.383968.366586@pizda.ninka.net>; from davem@redhat.com on Thu, Jan 25, 2001 at 05:04:23PM -0800
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 05:04:23PM -0800, David S. Miller wrote:
> 
> CaT writes:
>  > gozer:~# more /proc/sys/net/ipv4/tcp_ecn 
>  > 1
>  > 
>  > and I can contact hotmail just fine.
>  ...
>  > where should I go to on hotmail to see it fail?
> 
> Try telnetting to port 25 on one of their
> "*.hotmail.com" MX records.

Boom. Bingo:

gozer:~# telnet mc6.law5.hotmail.com 25
Trying 216.33.238.136...
telnet: Unable to connect to remote host: Connection refused

Big baddaboom :)

And it answers my question of wether or not it does ECN for non-ECN
boxes behind the firewall:

[11:29:31] root@theirongiant:/root>> telnet mc6.law5.hotmail.com 25
Trying 216.33.238.136...
Connected to mc6.law5.hotmail.com.
Escape character is '^]'.
220-HotMail (NO UCE) ESMTP server ready at Thu Jan 25 17:06:07 2001 
220 ESMTP spoken here
554 Transaction failed
Connection closed by foreign host.
[12:06:37] root@theirongiant:/root>> uname -a
Linux theirongiant 2.2.19pre7 #3 Tue Jan 16 18:07:56 EST 2001 i686 unknown

Thanks for that. :) I'll be leaving ECN turned on on the box regardless
I think.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
