Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbRBLSLP>; Mon, 12 Feb 2001 13:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129527AbRBLSLH>; Mon, 12 Feb 2001 13:11:07 -0500
Received: from [206.245.154.69] ([206.245.154.69]:64009 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S129426AbRBLSKu>; Mon, 12 Feb 2001 13:10:50 -0500
Date: Mon, 12 Feb 2001 13:10:48 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: shared memory problem
Message-ID: <Pine.LNX.4.10.10102121304250.24584-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been using the 2.2.x series successfully, latest i used
was 2.2.19pre7.
Today i upgraded to 2.4.1-ac9 and noticed that shared memory shows 0.
I searched the list archive briefly and someone said the stats have been
broken since sometime in 2.3, but my system also shows my swap being used
up a great deal (100MB whereas i'm rarely using more than 5MB (and that
only at loaded times, which this isn't))

this server is dedicated for apache web serving, and CONFIG_TMPFS is not
configured in/any shm fs mounted. I didn't have this in 2.2 either.

here's my /proc/meminfo and ipcs info..any help or advice is appreciated.


        total:    used:    free:  shared: buffers:  cached:
Mem:  327745536 319848448  7897088        0 17149952 199004160
Swap: 133885952 108236800 25649152
MemTotal:       320064 kB
MemFree:          7712 kB
MemShared:           0 kB
Buffers:         16748 kB
Cached:         194340 kB
Active:         159896 kB
Inact_dirty:     48692 kB
Inact_clean:      2500 kB
Inact_target:      252 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       320064 kB
LowFree:          7712 kB
SwapTotal:      130748 kB
SwapFree:        25048 kB


ipcs -lm

------ Shared Memory Limits --------
max number of segments = 4096
max seg size (kbytes) = 32768
max total shared memory (kbytes) = 8388608
min seg size (bytes) = 1

ipcs -m shows many segments used by apache servers.

------ Shared Memory Segments --------
shmid     owner     perms     bytes     nattch    status
0         young-w   600       46084     3         dest
32769     nobody    600       46084     6         dest
<snipped about 170 more..>

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
