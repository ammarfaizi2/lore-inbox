Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSFFI2i>; Thu, 6 Jun 2002 04:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSFFI2i>; Thu, 6 Jun 2002 04:28:38 -0400
Received: from daimi.au.dk ([130.225.16.1]:26325 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316883AbSFFI2g>;
	Thu, 6 Jun 2002 04:28:36 -0400
Message-ID: <3CFF1D2C.5861132C@daimi.au.dk>
Date: Thu, 06 Jun 2002 10:28:28 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Derek Vadala <derek@cynicism.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.GSO.4.21.0206051716530.16571-100000@gecko.roadtoad.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Vadala wrote:
> 
>   RAID-1 --------> RAID-5 (D0,D1,D2,D3,P0)
>               |--> RAID-5 (D0,D1,D2,D3,P0)
>    (four disks used for data, only one from each RAID-5 can fail)

Wrong, any three disks can fail. If the one RAID has only
one faulty disk, the other RAID can have any number of
faulty disks without loosing data.

> 
> With RAID-10:
> 
>   RAID-0 --------> RAID-1 (D0,D0)
>               |--> RAID-1 (D1,D1)
>               |--> RAID-1 (D2,D2)
>               |--> RAID-1 (D3,D3)
>               |--> RAID-1 (D4,D4)
>    (five disks used for data, one from each mirror can fail)
> 
> With RAID-50:
> 
>   RAID-0 --------> RAID-5 (D0,D2,D4,D6,P0)
>               |--> RAID-5 (D1,D3,D5,D7,P0)
> 
>    (two disks wasted only one from each RAID-5 can fail)
> 
> I believe that I/O performance would be similar for each
> configuration. I'll try to run some tests in the next few days.

I'd guess that depends on the access patterns.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
