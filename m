Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSCCWOW>; Sun, 3 Mar 2002 17:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSCCWON>; Sun, 3 Mar 2002 17:14:13 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:28327 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289298AbSCCWOD>;
	Sun, 3 Mar 2002 17:14:03 -0500
Date: Sun, 03 Mar 2002 22:13:49 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Arnvid Karstad <arnvid@karstad.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Linux 2.4.x, ThinkPad T23 and HW?!
Message-ID: <1848433232.1015193629@[195.224.237.69]>
In-Reply-To: <20020228233954.7840.qmail@nextgeneration.speedroad.net>
In-Reply-To: <20020228233954.7840.qmail@nextgeneration.speedroad.net>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnvid,

--On Friday, 01 March, 2002 12:39 AM +0100 Arnvid Karstad 
<arnvid@karstad.org> wrote:

> I just recieved an new laptop, an IBM ThinkPad T23 and it seems I cannot
> run the os of my choice on it.. Well almost not.. ;-)
> The strange thing is, almost none of these come up as
> "known" devices from /proc/pci or lspci.

This just means their ID's are missing from some text file. This
should not impede drivers from recognizing them. If you are bothered,
send code :-)

> I also noticed that the IBM
> Wireless adapter, which is actually a prism2 (?) card, are mysteriously
> detected as an device created by "Harris Semiconductor"

Both correct

> and it won't even
> try to let me access the card. I think I've tried every driver in the
> Kernel 2.4.18 now.

Well I think the giveaway here might be:

> I tried the Wlan-NG drivers but they didn't seem to work out as
> planned either...

Either your IBM's wireless LAN is dead (does it work under
Windows?) or perhaps you forgot to associate
the card:

> Prism2 card SN: 124112003411
> p80211knetdev_hard_start_xmit: Tx attempt prior to association,
> frame dropped.

looks like it - try:
  /sbin/wlanctl-ng wlan0 lnxreq_autojoin ssid='' authtype=opensystem

with the wlan-ng drivers and see if that fixes it.

I haven't got the kernel drivers working yet (laziness) but
I'm sure they will work just fine if wlan-ng works.

You might or might not find
  http://www.alex.org.uk/T23
useful

--
Alex Bligh
