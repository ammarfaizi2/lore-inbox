Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262483AbRENU2c>; Mon, 14 May 2001 16:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbRENU2M>; Mon, 14 May 2001 16:28:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16132 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262479AbRENU2D>; Mon, 14 May 2001 16:28:03 -0400
Message-ID: <3B003FB0.9D12436A@transmeta.com>
Date: Mon, 14 May 2001 13:27:28 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zOfH-0001LG-00@the-village.bc.nu> <3B003EFC.61D9C16A@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Note also that persistence of permissions and hardcoded in-kernel naming
> is a problem throughout proc...  It's not unique to in-driver
> filesystems.
>

It's not so much about hardcoding the names as hardcoding the *STRUCTURE*
of the names.  For example, the current devfs has /dev/misc/* which is
completely bogus -- it exposes an implementation detail (using the
miscdev API as opposed to the charmajor API) which should be hidden; in
fact a number of drivers have started their lives as miscdev devices and
changed over time.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
