Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbRFCMka>; Sun, 3 Jun 2001 08:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262923AbRFCMes>; Sun, 3 Jun 2001 08:34:48 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13751 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262903AbRFCMLv>;
	Sun, 3 Jun 2001 08:11:51 -0400
Message-ID: <3B1A2982.C53B159C@mandrakesoft.com>
Date: Sun, 03 Jun 2001 08:11:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Frazer <mark@somanetworks.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: MII access (was [PATCH] support for Cobalt Networks (x86 only)
In-Reply-To: <Pine.LNX.4.33.0106031343530.31050-100000@kenzo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> With clearer mind, I have to make some a correction to one of the previous
> messages: the problem of not checking arguments range does not apply to
> 3c59x which has in the ioctl function '& 0x1f' for both transceiver number
> and register number. However, eepro100 and tulip don't do that. (I'm
> checking now with 2.4.3 from Mandrake 8, but I don't think that there were
> recent changes in these areas).

half right -- tulip does this for the phy id but not the MII register
number.  I'll fix that up.  Please bug Andrey about fixing up
eepro100...

-- 
Jeff Garzik      | Echelon words of the day, from The Register:
Building 1024    | FRU Lebed HALO Spetznaz Al Amn al-Askari Glock 26 
MandrakeSoft     | Steak Knife Kill the President anarchy echelon
                 | nuclear assassinate Roswell Waco World Trade Center
