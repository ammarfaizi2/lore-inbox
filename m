Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSL2Taj>; Sun, 29 Dec 2002 14:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSL2Taj>; Sun, 29 Dec 2002 14:30:39 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:34688 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S261370AbSL2Tai>; Sun, 29 Dec 2002 14:30:38 -0500
Date: Sun, 29 Dec 2002 20:38:59 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Bugs in 2.5.53-bk4: ide-scsi, cdrom, unix socket, /proc/stat
Message-ID: <20021229193859.GA739@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) ide-scsi
Running kernel with these parameters:
kernel /boot/vmlinuz-2.5.53bk4 ro root=/dev/hda1 hdg=ide-scsi ide=reverse vga=4 hde=noprobe hdf=noprobe
at boot time it complains:
 scsi scan: host 0 channel 0 id 0 lun 0 identifier too long, length 60, max 50.
Device might be improperly identified.
at ide-scsi initialization and it freezes.
It is Teac CD-W512EB 2.0A.
 
2) if I disable hdg=ide-scsi than I got 
end_request: I/O error, dev hdg, sector 0
end_request: I/O error, dev hdg, sector 0
cdrom: open failed.
end_request: I/O error, dev hdg, sector 0
end_request: I/O error, dev hdg, sector 0
at any time someone access cdrom when cd is not inserted. Autofs has some
troubles with it. Any application is blocked until cd is inserted when using
autofs.

3) X server does not start at all complaining it cannot create listening socket.
On 2.5.52bk4 or 2.4.x is all OK.

4) I still do not see any disk_io line in /proc/stat so xosview does not show
disk usage.

-- 
Luká¹ Hejtmánek
