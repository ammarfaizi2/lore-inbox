Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275230AbSKEDRT>; Mon, 4 Nov 2002 22:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275238AbSKEDRS>; Mon, 4 Nov 2002 22:17:18 -0500
Received: from 205-158-62-90.outblaze.com ([205.158.62.90]:31453 "HELO
	ws3-6.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S275230AbSKEDRP>; Mon, 4 Nov 2002 22:17:15 -0500
Message-ID: <20021105032347.11253.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 04 Nov 2002 22:23:43 -0500
Subject: Re: LKCD ("It's the disk, pinheads.")
X-Originating-Ip: 172.191.250.30
X-Originating-Server: ws3-6.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless the server is purely a router or bridge, where
"the money" lives entirely in ram and the only thing
on the disk is the boot image and associated infrastructure,
"the money" (database, work in progress, whatever)lives
on your hard drives.

Linus is just telling you that trying to write to one
of dozens of possible hd driver interfaces from
a kernel that has just paniced is gambling with
"the money", and he isn't willing to merge (and
would not himself use) a patch that takes that risk.

Like he says, the situation is different on systems
that only have drivers for a tiny number of different
disk interfaces, and objecting to his attitude while
ignoring this issue is arguing in bad faith.

If you want to dump to the network or to a serial
port, that's different. How many different serial
port drivers are there?

The robust solution is to hook that serial port up
to a cheap little box sleeping on a serial port
interrupt whose only job is to react to that interrupt
and capture the crash dump to its own local disk,
which isn't being managed by a kernel that just
paniced. (If you want to give it a send-only network
interface to the outside world for rapid notification,
that's up to you. You could put ssh on it too, but the
more you add, the less robust a solution it is to its
real job, which is providing a stable interface to a
disk for crash dumps.)

Regards,
Clayton Weaver
<mailto: cgweav@email.com>

PS: This is my first message from email.com. Let me
know if it shows up in html or has any other
obnoxious features characteristic of clueless
email clients.




-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Single & ready to mingle? lavalife.com:  Where singles click. Free to Search!
http://www.lavalife.com/mailcom.epl?a=2116

