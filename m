Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSGHWIx>; Mon, 8 Jul 2002 18:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSGHWIw>; Mon, 8 Jul 2002 18:08:52 -0400
Received: from hell.ascs.muni.cz ([147.251.60.186]:18050 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S317184AbSGHWIw>; Mon, 8 Jul 2002 18:08:52 -0400
Date: Tue, 9 Jul 2002 00:11:37 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Terrible VM in 2.4.11+?
Message-ID: <20020709001137.A1745@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echalon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mosad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

as of the last stable version 2.4.18 VM management does not work for me
properly. I have Athlon system with 512MB ram, 2.4.18 kernel without any
additional patches.

I run following sequence of commands:

dd if=/dev/zero of=/tmp bs=1M count=512 &
find / -print &
 { wait a few seconds }
sync

at this point find stops completely or at least almost stops.

The same if I copy from /dev/hdf to /dev/hda. XOSVIEW shows only reading or only
writing (as bdflushd is flushing buffers). It never shows parallel reading and
writing. /proc/sys/* has default settings. I do not know the reason why i/o
system stops when bdflushd is flushing buffers nor reading can be done.

-- 
Luká¹ Hejtmánek
