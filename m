Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131370AbQKAPmM>; Wed, 1 Nov 2000 10:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131371AbQKAPly>; Wed, 1 Nov 2000 10:41:54 -0500
Received: from james.kalifornia.com ([208.179.0.2]:10825 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131370AbQKAPlp>; Wed, 1 Nov 2000 10:41:45 -0500
Message-ID: <3A0039BB.74558944@kalifornia.com>
Date: Wed, 01 Nov 2000 07:41:47 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: hang ftp connections...
In-Reply-To: <Pine.LNX.4.21.0011011000580.1722-100000@saturn.homenet>
Content-Type: multipart/mixed;
 boundary="------------185CD37A64F4E9CBD7E08FFB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------185CD37A64F4E9CBD7E08FFB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have a very similar problem.  I am running test10-pre5 (x86).  I can accept
uploaded FTP all day long, but when downloading from me, my network dies in
very short order.  This was a windows box that was killing me (both ME and
2000).  These are about 100 2-4 meg files that I'm talking about.  I didn't
see any significant log entries, but there was one oddity.  There were 4
incorrect FTP login attempts recorded when I actually logged in successfully
the first time.

I bring the network down (ifconfig eth0 down), kill dhclient then bring it
back up and restart dhclient.  That seems to work, but it's a pain in the
butt.

-b


Tigran Aivazian wrote:

> Hi guys,
>
> I noticed this since I installed test10-pre5 (maybe 6) on my
> desktop. FTP connections to Solaris became very strange, i.e. after the
> transfer is finished it would never actually close the control socket and
> hang it there. So, I assumed that most likely Solaris kernel is full of
> bugs (as a commercial OS ought to be) and they don't even implement FTP
> protocol correctly, so that the exceeding correctness of ours at
> test10-preX shows their bugs. However, now the same thing happened when
> talking to ftp.kernel.org and that surely runs Linux. So there must be a
> bug somewhere. I will now upgrade all my systems to final proper test10
> and see if the problem is still there...
>
> I only noticed this with ftp; other critical services (irc, telnet etc.)
> work fine.
>
> Regards,
> Tigran
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--------------185CD37A64F4E9CBD7E08FFB
Content-Type: text/plain; charset=us-ascii;
 name="ftp-fuckup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ftp-fuckup"

Oct 28 16:55:36 Deacon -- MARK --
Oct 28 17:15:36 Deacon -- MARK --
Oct 28 17:23:30 Deacon proftpd[10662]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - USER lori (Login failed): Incorrect password. 
Oct 28 17:23:30 Deacon proftpd[10662]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - FTP session closed. 
Oct 28 17:23:32 Deacon proftpd[10663]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - USER lori (Login failed): Incorrect password. 
Oct 28 17:23:32 Deacon proftpd[10663]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - FTP session closed. 
Oct 28 17:23:33 Deacon proftpd[10665]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - USER lori (Login failed): Incorrect password. 
Oct 28 17:23:33 Deacon proftpd[10665]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - FTP session closed. 
Oct 28 17:23:36 Deacon proftpd[10664]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - USER lori (Login failed): Incorrect password. 
Oct 28 17:23:36 Deacon proftpd[10664]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - FTP session closed. 
Oct 28 17:23:44 Deacon proftpd[10668]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - USER lori: Login successful. 
Oct 28 17:23:44 Deacon proftpd[10669]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - USER lori: Login successful. 
Oct 28 17:27:56 Deacon kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 28 17:28:28 Deacon last message repeated 4 times
Oct 28 17:28:44 Deacon last message repeated 2 times
Oct 28 17:28:44 Deacon proftpd[10668]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - FTP no transfer timeout, disconnected. 
Oct 28 17:28:52 Deacon kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 28 17:29:24 Deacon last message repeated 4 times
Oct 28 17:30:28 Deacon last message repeated 8 times
Oct 28 17:31:32 Deacon last message repeated 8 times
Oct 28 17:32:36 Deacon last message repeated 8 times
Oct 28 17:32:44 Deacon kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 28 17:32:48 Deacon proftpd[10669]: Deacon.itchyscratchy.org (192.168.0.30[192.168.0.30]) - FTP no transfer timeout, disconnected. 
Oct 28 17:32:52 Deacon kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 28 17:33:16 Deacon last message repeated 3 times
Oct 28 17:33:17 Deacon su[10695]: - pts/0 ben-root 
Oct 28 17:33:22 Deacon su[10696]: + pts/0 ben-root 
Oct 28 17:33:24 Deacon kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 28 17:33:56 Deacon last message repeated 4 times
Oct 28 17:35:00 Deacon last message repeated 8 times

--------------185CD37A64F4E9CBD7E08FFB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
