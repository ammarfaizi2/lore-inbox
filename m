Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318716AbSICHQF>; Tue, 3 Sep 2002 03:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318717AbSICHQF>; Tue, 3 Sep 2002 03:16:05 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:51716 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S318716AbSICHQE>; Tue, 3 Sep 2002 03:16:04 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200209030719.g837JCJ24173@sprite.physics.adelaide.edu.au>
Subject: Re: Linux 2.4.18: short dd read from IDE cdrom
To: linux-kernel@vger.kernel.org
Date: Tue, 3 Sep 2002 16:49:12 +0930 (CST)
Cc: axboe@suse.de, andre@linux-ide.org,
       jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
In-Reply-To: <200209020527.g825RHd07114@sprite.physics.adelaide.edu.au> from "Jonathan Woithe" at Sep 02, 2002 02:57:17 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Yesterday I reported a problem to lkml I observed with `dd' and ide cds:
> For a number of years now I have duplicated cds using
>   dd if=/dev/cdrom of=foo.iso
>   cdrecord ... foo.iso
> :
> Today I tried the same trick under 2.4.18 and struck a problem: the kernel
> would not read the complete CD image. ...

After further testing, it seems that turning off dma using "hdparm -d 0
/dev/hdc" allows things to work as expected - the full disk can be read and
the resulting image is intact.  It appears therefore that the problem may
lie in the ide DMA error recovery code.  Alan Cox eluded to this possibility
in Dec 2001 (lkml, 28 Dec 2001, subject "Re: dd cdrom error") but it's not
clear whether the issue was pursued by anyone at that time.  Does anyone
know whether this is now being addressed by Andre in his latest round of
patches via the ac tree, or has already been fixed?

Please CC me any replies.  Thanks.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *
