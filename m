Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265100AbRF0SJn>; Wed, 27 Jun 2001 14:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbRF0SJd>; Wed, 27 Jun 2001 14:09:33 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39096 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264945AbRF0SJY>;
	Wed, 27 Jun 2001 14:09:24 -0400
Message-ID: <3B3A2176.11AF40E3@mandrakesoft.com>
Date: Wed, 27 Jun 2001 14:09:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: EEPro100 bug in 2.4.6pre5
In-Reply-To: <E15FHyv-0005Q0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Someone has done S/CONFIG_EEPRO100_PM/CONFIG_PM/ on the driver and in doing
> so permanently enabled the eepro100 pm code which to say the least doesnt work
> for a lot of people but gives them weird eepro100 hangs

Do you have a bug report of this actually breaking?

eepro100 is doing standard PCI PM.  The only reason AFAICS why it was
breaking for people was that the previous PCI PM code did not do all the
stuff it needed to do.  PCI PM should cover the various cases correctly,
now, ditto eepro100.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
