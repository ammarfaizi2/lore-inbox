Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAPPB>; Fri, 1 Dec 2000 10:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLAPOv>; Fri, 1 Dec 2000 10:14:51 -0500
Received: from windsormachine.com ([206.48.122.28]:14866 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129210AbQLAPOf>; Fri, 1 Dec 2000 10:14:35 -0500
Message-ID: <3A27B931.DEADF643@windsormachine.com>
Date: Fri, 01 Dec 2000 09:44:01 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gvlyakh@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA for triton again...
In-Reply-To: <E141oUr-0006C9-00@f10.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Guennadi Liakhovetski wrote:

> Hi
> > will try tonight... and will let you know tomorrow...
> ... Nop, it didn't work. Mike and everybody having experience / knowledge of Western Digital Caviar AC21600H... If you compare WD's documents at:
> http://www.westerndigital.com/service/FAQ/dtr.html
> and
> http://www.westerndigital.com/products/non-current/drives/ac21600.html
> they, respectively ,say:
>
> UDMA if CCC is A8-AG (AH is not UDMA), D5-D7, Bx, or Cx All others -- PIO Mode 4
>
> and
>
> 16.6 MB/s (burst Mode 4 PIO) *
> 16.6 MB/s (burst Mode 2 DMA) **
> 33.3 MB/s (Mode 2 Ultra DMA) ***
>
> *Max PIO burst rate is specified at 16.6 MB/s using the IORDY signal.
> **Max DMA and multi-word DMA burst rate is specified using the DMARQ and DMACK signals.
> ***Mode 2 Ultra DMA is supported in the following firmware revisions (CCC Codes: A8, AA, AC, AD, AG, D5, D6, D7, Bx, Cx).
>
> Which one is true? Do non-UDMA AC21600H (I've got CCC F6) support DMA?
>
> Is it possible to find out where hdparm -d1 is stopped? Maybe by compiling it with -g and debugging... As far as I understand, BIOS is not an issue, since ide.txt says, that Linux doesn't use BIOS when working with hard drives...
>
> Thanks
> Guennadi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Well, per my other email, i found a case where the bios DID matter.  Yes, the AC21600H supports DMA.  Even my dinosaur 850 meg in that same box, works in dma mode, and does get a little bit faster.  They're so slow in the first place
that it doesn't make much transfer rate difference, but the cpu load goes way down.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
