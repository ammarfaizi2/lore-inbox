Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935143AbWKYEGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935143AbWKYEGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 23:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935142AbWKYEGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 23:06:43 -0500
Received: from free.hands.com ([83.142.228.128]:52449 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S935143AbWKYEGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 23:06:42 -0500
Date: Sat, 25 Nov 2006 04:06:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>,
       kernel-discuss@handhelds.org
Subject: tty line discipline driver advice sought, to do a 1-byte header and 2-byte CRC checksum on GSM data
Message-ID: <20061125040614.GI16214@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello darlings, please cc me because i am not subscribed to these lists.  ta.
i am cross-posting because, whilst this is for a phone device, it's
actually a request for help on tty line discipline driver writing.


you may have heard of quite a bit of fuss over linux mobile phones,
recently, with the introduction of the Neo1973 from www.fic.com.tw and
the greenphone from www.trolltech.com - well, there are a few more
devices around which are tantalisingly close to being useable: the
htc universal, the htc sable (ipaq hw6915) and also the h6300 series i
understand is _already_ actually useable - it even has a gsm management
daemon (http://www.mulliner.org/h63xxlinux/feed/mplexd-0.1.tar.gz)

some of you may have also seen this:

	http://www.handhelds.org/hypermail/kernel-discuss/19/1961.html

that's the background.

my question is this: having looked at the htc sable's K700 gsm module,
which talks some weird proprietary but easily-reverse-engineered protocol:

	http://wiki.xda-developers.com/index.php?pagename=SablePhone

and having read harald's email, and basically gone 'cool!', and, having
then looked up 'tty line discipline' on google (_before_ writing
this...) and gone 'errr...' i was wondering:

could someone kindly advise me how to write a tty line discipline
driver?

i need to add one byte to the front (0x2) then a 2-byte length field,
then send the data that's written, then a 2-byte CRC-16 checksum, and, also,
on a read, to check that the first byte is a 0x2, then read the length
field, then that many bytes, and confirm the 2-byte CRC-16 checksum of
the data just read.

i've never encountered tty line discipline's before.  which one is the
best example that i should start with to cut/paste?  has anyone else
done this sort of thing before, such that i can start with their code
and do a minimum amount of work to get this done - quickly?  can anyone
point me at userspace test example source code?

etc. etc.

... alternatively, i just... don't do this at all - i leave it to
userspace, which would be a hell of a lot easier, but would make
applications a pain, because they would need to use a library instead of
just opening /dev/ttySN just like any other phone app, to transfer AT
commands.

your kind assistance to further the free software community's standing
by successfully owning their own mobile phone is greatfully appreciated.

l.

--
lkcl.net - mad free software computer person, visionary and poet.
--
