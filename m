Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269781AbRHIMU5>; Thu, 9 Aug 2001 08:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269785AbRHIMUs>; Thu, 9 Aug 2001 08:20:48 -0400
Received: from willow.commerce.uk.net ([213.219.35.202]:21000 "EHLO
	willow.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S269781AbRHIMUf>; Thu, 9 Aug 2001 08:20:35 -0400
Date: Thu, 9 Aug 2001 13:18:51 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: linux-kernel@vger.kernel.org
Subject: Setting up MTRRs for 4096MB RAM
Message-ID: <Pine.LNX.4.21.0108091306550.18150-100000@willow.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I am trying to set up a machine using the Tyan Tiger LE motherboard, and
ServerWorks III LE chipset to use 4096MB RAM. I'm using kernel 2.4.7 with
CONFIG_HIGHMEM4G.

I know that I have to set the MTRR's up to extend the cacheable memory
area, but can't work out how to set it up.

I tried the following:

  # echo "disable=1" >| /proc/mtrr
  # echo "disable=0" >| /proc/mtrr
  # echo "base=0x0 size=0xFFFFFFFF type=write-back" >| /proc/mtrr
  mtrr: size and base must be multiples of 4 kiB
  mtrr: size: 0xffffffff  base: 0x0

Which doesn't make any sense. So I tried for 3G RAM:

  # echo "base=0x0 size=0xC0000000 type=write-back" >| /proc/mtrr
  mtrr: base(0x0000) is not aligned on a size(0xc0000000) boundary

And then for 2G RAM:

  # echo "base=0x0 size=0x80000000 type=write-back" >| /proc/mtrr

Which works perfectly. What gives?

Also: the instructions in Documentation/mtrr.txt says to use ">|" instead
of ">" (under bash, at least) - what does this accomplish?

Thanks,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        | 
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/

