Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283045AbRK1N5U>; Wed, 28 Nov 2001 08:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282142AbRK1N5O>; Wed, 28 Nov 2001 08:57:14 -0500
Received: from [132.69.253.140] ([132.69.253.140]:38614 "HELO alon1.dhs.org")
	by vger.kernel.org with SMTP id <S283045AbRK1N47>;
	Wed, 28 Nov 2001 08:56:59 -0500
Date: Wed, 28 Nov 2001 15:56:25 +0200 (IST)
From: <kernel@alon.wox.org>
X-X-Sender: <alon@alon1.dhs.org>
To: <linux-kernel@vger.kernel.org>
Subject: NFS long wait problem
Message-ID: <Pine.LNX.4.33L2.0111281553120.786-100000@alon1.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have a problem with my home network. I have a client PC which mounts
/home as an NFS share on the server. Once in a while, all access to the
mounted directory is stalled and the following data is transferred on the
network:

06:45:23.270071 192.168.1.2.1402759134 > 192.168.1.1.2049: 100 null (DF)
06:45:23.271049 192.168.1.1.2049 > 192.168.1.2.1402759134: reply ok 24 null (DF)
06:45:23.271105 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @ 0x04019e000 (DF)
06:45:24.670061 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @ 0x04019e000 (DF)
06:45:27.470062 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @ 0x04019e000 (DF)
06:45:33.070065 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @ 0x04019e000 (DF)
06:45:44.270083 192.168.1.2.1419536350 > 192.168.1.1.2049: 100 null (DF)
06:45:44.270563 192.168.1.1.2049 > 192.168.1.2.1419536350: reply ok 24 null (DF)
06:45:44.270619 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @ 0x04019e000 (DF)
06:45:47.070068 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @ 0x04019e000 (DF)
06:45:52.670060 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @ 0x04019e000 (DF)
06:46:03.870068 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @ 0x04019e000 (DF)
06:46:04.115689 192.168.1.1.2049 > 192.168.1.2.1302095838: reply ok 136 write [|nfs] (DF)

  This cannot be a physical link problem, as other packets get transferred
correctly on the same link. When this happens, it's always with NFS V3 WRITE
calls. Any ideas?

  I'm running MDK8.1 (kernel 2.4.8-19mdk) on both the client and the server.

Thanks in advance,
  Alon

-- 
This message was sent by Alon Altman (Psycho99@bigfoot.com) ICQ:1366540
The RIGHT way to contact me is by e-mail. I am otherwise nonexistent :)
--------------------------------------------------------------------------
"jackpot:  you may have an unneccessary change record"
-- message from "diff"


=================================================================
To unsubscribe, send mail to linux-il-request@linux.org.il with
the word "unsubscribe" in the message body, e.g., run the command
echo unsubscribe | mail linux-il-request@linux.org.il


-- 
This message was sent by Alon Altman (Psycho99@bigfoot.com) ICQ:1366540
The RIGHT way to contact me is by e-mail. I am otherwise nonexistent :)
--------------------------------------------------------------------------
You don't have to know how the computer works, just how to work the computer.

