Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTFIKDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTFIKDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:03:24 -0400
Received: from camus.xss.co.at ([194.152.162.19]:61956 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S261249AbTFIKDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:03:15 -0400
Message-ID: <3EE45E94.7070209@xss.co.at>
Date: Mon, 09 Jun 2003 12:16:52 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [2.4.21-rc7] AP1700-S5 system freeze :-((
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva> <3EDF3310.7040501@xss.co.at> <3EE208F1.4000008@xss.co.at>
In-Reply-To: <3EE208F1.4000008@xss.co.at>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Note: I'm reporting this with a different subject line now,
as I got zero replies to my first bugreport. This is still
the same Asus AP1700-S5 server as in my previous reports,
though:

Asus AP1700-S5 server, single Xeon 2.4GHz CPU (FSB533)
512MB registered DDR with ECC, Asus PR-DLS533 motherboard
with ServerWorks GCLE chipset

root@server:~ {535} $ lspci
00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 31)
00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
01:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)

Andreas Haumer wrote:
[...]
> I had this system running under heavy load for about 24 hours
> without problems. I then stopped the stress testing, and had
> several system freezes since then.
>
> With system freeze I mean:
>
> *) machine doesn't answer to ping, no reaction to console
>    keyboard, no message on the console screen, no message
>    in logfile, no oops, no noticeable system activity
>
I just had another freeze or lockup of this system,
after 1 day and 14 hours uptime. :-(

This time the machine was running with an 3Com 3c905c
100MBit NIC, with the onboard e1000 GBit controllers disabled.
Obviously, this didn't help, too...

When I noticed the freeze, I tried to ping the server,
and got a few replies back, but with a delay of more than
60 seconds! I didn't wait that long when I tried to ping
the server on the previous lockups, so maybe the "no answer
to ping" symptom I described is more a "big delay in
answering ping packets" symptom. Does that ring any bell?

Any idea anyone?

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+5F6HxJmyeGcXPhERApOfAJ4klAsR0lA8Zzk5s22quImzxud6agCgvAi1
FXZuNQV3C4UaKVi9gOvtJFM=
=qL4B
-----END PGP SIGNATURE-----

