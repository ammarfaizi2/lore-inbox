Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278625AbRKAJkm>; Thu, 1 Nov 2001 04:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278630AbRKAJkc>; Thu, 1 Nov 2001 04:40:32 -0500
Received: from castle.nmd.msu.ru ([193.232.112.53]:34578 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S278625AbRKAJkS>;
	Thu, 1 Nov 2001 04:40:18 -0500
Message-ID: <20011101124751.B26220@castle.nmd.msu.ru>
Date: Thu, 1 Nov 2001 12:47:51 +0300
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: =?koi8-r?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no> <20011031182212.A21776@castle.nmd.msu.ru> <20011101085523.D2102@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.93.2i
In-Reply-To: =?koi8-r?Q?=3C20011101085523=2ED2102=40stud=2Entnu=2Eno=3E=3B_from_=22Th?=
 =?koi8-r?Q?omas_Lang=E5s=22_on_Thu=2C_Nov_01=2C_2001_at_08:55:23AM?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 08:55:23AM +0100, Thomas Langås wrote:
> Andrey Savochkin:
> > Well, with eepro100 the start may be the following:
> > 1. When the card stalls, start ping from that host.
> > This way you ensure that you have something in transmit ring.
> > If it's transmitting that stalls, you'll get a message from netdev watchdog.
> 
> From the server, or the client?  I've already tried pinging from the server

>From the computer where the network card hangs and where you see messages in
dmesg.  The network card hangs on only one side, right?

> when I get the error-message in dmesg, but it's unresponsive to anything.
> And, I mean anything, network-wise. There seems to be a timeout somewhere,
> because after some time, everything resumes back to normal again.

If the operations stall just for few seconds, it's perfectly ok.
If after a few second stop the card itself resumes to operate normally, but
NFS operations are blocked for much longer time, it's NFS problem.
If the card itself stops operation for a long time, it needs to be fixed.

	Andrey
