Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265441AbRF0XQY>; Wed, 27 Jun 2001 19:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265443AbRF0XQO>; Wed, 27 Jun 2001 19:16:14 -0400
Received: from 24-25-197-107.san.rr.com ([24.25.197.107]:8723 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S265441AbRF0XQD>;
	Wed, 27 Jun 2001 19:16:03 -0400
Date: Wed, 27 Jun 2001 16:16:00 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the best way for multiple net_devices
Message-ID: <20010627161600.C23834@ecam.san.rr.com>
In-Reply-To: <3B3A5852.AAEF9531@mandrakesoft.com> <20010627145201.A23834@ecam.san.rr.com> <3B3A5852.AAEF9531@mandrakesoft.com> <20010627151829.B23834@ecam.san.rr.com> <4.3.1.0.20010627153532.036e9320@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <4.3.1.0.20010627153532.036e9320@mail1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 03:36:37PM -0700, Maksim Krasnyanskiy wrote:
> 
> >Any examples of drivers and apps that do this cleanly. The ones I have seen are not.
> TUN/TAP driver and tuncfg utility
> http://vtun.sf.net/tun

OK, thanks that is nice, but I think adding support to get into the /dev
namespace may be a little heavy for things like bonding or ipip.

I did not see tuncfg. From what I could see there were 2 ways to create
new devices. There was a script with mknod and then the ioctl(fd, TUNSETIFF, 
(void *) &ifr).

I could do a similar ioctl for a pure net device but I still need a dummy
socket for creating/destroying devices.

I am going for an embedded system so I want to keep things light.
