Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268001AbTAHURF>; Wed, 8 Jan 2003 15:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbTAHURF>; Wed, 8 Jan 2003 15:17:05 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:27008 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S268001AbTAHURE>; Wed, 8 Jan 2003 15:17:04 -0500
Date: Wed, 8 Jan 2003 21:25:42 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54: ide-scsi still buggy?
Message-ID: <20030108202542.GA870@mail.muni.cz>
References: <20030108014005.GC725@mail.muni.cz> <Pine.LNX.4.50.0301072116450.4046-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.50.0301072116450.4046-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 09:17:46PM -0500, Zwane Mwaikambo wrote:
> > It freezes kernel (sysrq do nothing) after lines:
> > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> >   Vendor: TEAC      Model: CD-W512EB         Rev: 2
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > scsi scan: host 0 channel 0 id 0 lun 0 identifier too long, length 60, max 50. Device might be improperly identified.
> >
> > while attaching it to /dev/hde works ok. Why?
> 
> This has been observed to cause an oops on some boxes and nothing on mine,
> try this patch from Andries

Acctualy this patch caused only I do not see "scsi scan: host 0 channel 0 id
0 lun 0 identifier too long, length 60, max 50. Device might be improperly
identified."

how ever after above message kernel causes hard hw lockup. IDE activity
LED is turned on but nothing else works. (nor sysrq)

I believe that code that report this message causes hw lockup. 
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray

-- 
Luká¹ Hejtmánek
