Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135427AbRANUDG>; Sun, 14 Jan 2001 15:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135455AbRANUDE>; Sun, 14 Jan 2001 15:03:04 -0500
Received: from [213.253.36.78] ([213.253.36.78]:41994 "HELO
	blackhole.uknet.spacesurfer.com") by vger.kernel.org with SMTP
	id <S135427AbRANUCs>; Sun, 14 Jan 2001 15:02:48 -0500
Message-ID: <3A620671.B6C15F01@spacesurfer.com>
Date: Sun, 14 Jan 2001 20:05:05 +0000
From: Patrick <patrick@spacesurfer.com>
Reply-To: pim@uknet.spacesurfer.com
Organization: SpaceSurfer Ltd.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops in tcp_ipv4.c
In-Reply-To: <200101141946.WAA25337@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > Recently I tried 2.2.17, this kernel was up for about a month, before
> > there was a kernel oops. The syslog messages are:
> 
> This is caused by illegal setting of /proc/sys/net/ipv4/ip_local_port_range
> with kernels before 2.2.18.
> 
> Do not touch this value or change it to something reasonable,
> f.e. to one of values recommended in net/ipv4/tcp_ipv4.c
> 
> Alexey

You are right I had the range set to 16384-65535!
I have changed the high limit to 61000, that should be ok.
Is there any point in having the low limit above 1024?


regards,
Patrick

-- 
Patrick Mackinlay                                patrick@spacesurfer.com
ICQ: 59277981                                        tel: +44 7050699851
                                                     fax: +44 7050699852
SpaceSurfer Limited                          http://www.spacesurfer.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
