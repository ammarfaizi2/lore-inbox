Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290662AbSBLBBm>; Mon, 11 Feb 2002 20:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290671AbSBLBBb>; Mon, 11 Feb 2002 20:01:31 -0500
Received: from echo.sound.net ([205.242.192.21]:60547 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S290662AbSBLBBJ>;
	Mon, 11 Feb 2002 20:01:09 -0500
Date: Mon, 11 Feb 2002 19:00:47 -0600 (CST)
From: Hal Duston <hald@sound.net>
To: linux-kernel@vger.kernel.org
cc: vojtech@suse.cz
Subject: Re: Input w/2.5.3-dj3
Message-ID: <Pine.GSO.4.10.10202111857040.7585-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, i8042_direct=1 fixed things for my wrong keys issue.
atkbd_set=3 didn't appear to make any difference (I think)
I'm using atkbd_set=2 currently, but I think =3 worked as well.

Log follows

Thanks,
Hal Duston
hald@sound.net

--- /var/log/debug ---
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 25 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 34 -> i8042 (parameter) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 25 -> i8042 (parameter) [0]
i8042.c: f6 -> i8042 (kbd-data) [0]
i8042.c: fa <- i8042 (interrupt-kbd) [1]
i8042.c: f2 -> i8042 (kbd-data) [1]
i8042.c: 60 -> i8042 (command) [1]
i8042.c: 34 -> i8042 (parameter) [1]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 25 -> i8042 (parameter) [2]
i8042.c: fa <- i8042 (interrupt-kbd) [2]
atkbd.c: Sent: f5
i8042.c: f5 -> i8042 (kbd-data) [2]
i8042.c: fa <- i8042 (interrupt-kbd) [3]
atkbd.c: Received fa
atkbd.c: Sent: f2
i8042.c: f2 -> i8042 (kbd-data) [3]
i8042.c: fa <- i8042 (interrupt-kbd) [4]
atkbd.c: Received fa
i8042.c: ab <- i8042 (interrupt-kbd) [5]
atkbd.c: Received ab
i8042.c: 84 <- i8042 (interrupt-kbd) [5]
atkbd.c: Received 84
atkbd.c: Sent: ea
i8042.c: ea -> i8042 (kbd-data) [5]
i8042.c: fe <- i8042 (interrupt-kbd) [6]
atkbd.c: Received fe
atkbd.c: Sent: f0
i8042.c: f0 -> i8042 (kbd-data) [6]
i8042.c: fa <- i8042 (interrupt-kbd) [6]
atkbd.c: Received fa
atkbd.c: Sent: 02
i8042.c: 02 -> i8042 (kbd-data) [6]
i8042.c: fa <- i8042 (interrupt-kbd) [7]
atkbd.c: Received fa
atkbd.c: Sent: f0
i8042.c: f0 -> i8042 (kbd-data) [7]
i8042.c: fa <- i8042 (interrupt-kbd) [8]
atkbd.c: Received fa
atkbd.c: Sent: 00
i8042.c: 00 -> i8042 (kbd-data) [8]
i8042.c: fa <- i8042 (interrupt-kbd) [9]
atkbd.c: Received fa
i8042.c: 02 <- i8042 (interrupt-kbd) [9]
atkbd.c: Received 02
atkbd.c: Sent: f8
i8042.c: f8 -> i8042 (kbd-data) [9]
i8042.c: fa <- i8042 (interrupt-kbd) [9]
atkbd.c: Received fa
atkbd.c: Sent: ed
i8042.c: ed -> i8042 (kbd-data) [10]
i8042.c: fa <- i8042 (interrupt-kbd) [11]
atkbd.c: Received fa
atkbd.c: Sent: 00
i8042.c: 00 -> i8042 (kbd-data) [11]
i8042.c: fa <- i8042 (interrupt-kbd) [11]
atkbd.c: Received fa
atkbd.c: Sent: f4
i8042.c: f4 -> i8042 (kbd-data) [11]
i8042.c: fa <- i8042 (interrupt-kbd) [11]
atkbd.c: Received fa
i8042.c: d3 -> i8042 (command) [12]
i8042.c: 5a -> i8042 (parameter) [12]
i8042.c: a5 <- i8042 (return) [12]
i8042.c: a9 -> i8042 (command) [12]
i8042.c: 00 <- i8042 (return) [12]
i8042.c: a7 -> i8042 (command) [12]
i8042.c: 20 -> i8042 (command) [12]
i8042.c: 25 <- i8042 (return) [12]
i8042.c: a9 -> i8042 (command) [12]
i8042.c: 00 <- i8042 (return) [12]
i8042.c: a8 -> i8042 (command) [12]
i8042.c: 20 -> i8042 (command) [12]
i8042.c: 05 <- i8042 (return) [12]
i8042.c: 60 -> i8042 (command) [12]
i8042.c: 25 -> i8042 (parameter) [12]
i8042.c: 60 -> i8042 (command) [12]
i8042.c: 07 -> i8042 (parameter) [12]
i8042.c: d4 -> i8042 (command) [12]
i8042.c: f6 -> i8042 (parameter) [12]
i8042.c: 60 -> i8042 (command) [12]
i8042.c: 07 -> i8042 (parameter) [12]
i8042.c: fa <- i8042 (interrupt-aux) [13]
i8042.c: d4 -> i8042 (command) [13]
i8042.c: f2 -> i8042 (parameter) [13]
i8042.c: 60 -> i8042 (command) [13]
i8042.c: 07 -> i8042 (parameter) [13]
i8042.c: fa <- i8042 (interrupt-aux) [13]
i8042.c: 00 <- i8042 (interrupt-aux) [14]
i8042.c: d4 -> i8042 (command) [14]
i8042.c: e8 -> i8042 (parameter) [14]
i8042.c: 60 -> i8042 (command) [14]
i8042.c: 07 -> i8042 (parameter) [14]
i8042.c: fa <- i8042 (interrupt-aux) [14]
i8042.c: d4 -> i8042 (command) [14]
i8042.c: 03 -> i8042 (parameter) [14]
i8042.c: 60 -> i8042 (command) [14]
i8042.c: 07 -> i8042 (parameter) [14]
i8042.c: fa <- i8042 (interrupt-aux) [14]
i8042.c: d4 -> i8042 (command) [14]
i8042.c: e6 -> i8042 (parameter) [14]
i8042.c: 60 -> i8042 (command) [14]
i8042.c: 07 -> i8042 (parameter) [14]
i8042.c: fa <- i8042 (interrupt-aux) [15]
i8042.c: d4 -> i8042 (command) [15]
i8042.c: e6 -> i8042 (parameter) [15]
i8042.c: 60 -> i8042 (command) [15]
i8042.c: 07 -> i8042 (parameter) [15]
i8042.c: fa <- i8042 (interrupt-aux) [15]
i8042.c: d4 -> i8042 (command) [15]
i8042.c: e6 -> i8042 (parameter) [15]
i8042.c: 60 -> i8042 (command) [15]
i8042.c: 07 -> i8042 (parameter) [15]
i8042.c: fa <- i8042 (interrupt-aux) [16]
i8042.c: d4 -> i8042 (command) [16]
i8042.c: e9 -> i8042 (parameter) [16]
i8042.c: 60 -> i8042 (command) [16]
i8042.c: 07 -> i8042 (parameter) [16]
i8042.c: fa <- i8042 (interrupt-aux) [16]
i8042.c: 00 <- i8042 (interrupt-aux) [16]
i8042.c: 03 <- i8042 (interrupt-aux) [16]
i8042.c: 64 <- i8042 (interrupt-aux) [17]
i8042.c: d4 -> i8042 (command) [17]
i8042.c: e8 -> i8042 (parameter) [17]
i8042.c: 60 -> i8042 (command) [17]
i8042.c: 07 -> i8042 (parameter) [17]
i8042.c: fa <- i8042 (interrupt-aux) [17]
i8042.c: d4 -> i8042 (command) [17]
i8042.c: 00 -> i8042 (parameter) [17]
i8042.c: 60 -> i8042 (command) [17]
i8042.c: 07 -> i8042 (parameter) [17]
i8042.c: fa <- i8042 (interrupt-aux) [17]
i8042.c: d4 -> i8042 (command) [17]
i8042.c: e6 -> i8042 (parameter) [17]
i8042.c: 60 -> i8042 (command) [18]
i8042.c: 07 -> i8042 (parameter) [18]
i8042.c: fa <- i8042 (interrupt-aux) [18]
i8042.c: d4 -> i8042 (command) [18]
i8042.c: e6 -> i8042 (parameter) [18]
i8042.c: 60 -> i8042 (command) [18]
i8042.c: 07 -> i8042 (parameter) [18]
i8042.c: fa <- i8042 (interrupt-aux) [18]
i8042.c: d4 -> i8042 (command) [18]
i8042.c: e6 -> i8042 (parameter) [18]
i8042.c: 60 -> i8042 (command) [18]
i8042.c: 07 -> i8042 (parameter) [18]
i8042.c: fa <- i8042 (interrupt-aux) [19]
i8042.c: d4 -> i8042 (command) [19]
i8042.c: e9 -> i8042 (parameter) [19]
i8042.c: 60 -> i8042 (command) [19]
i8042.c: 07 -> i8042 (parameter) [19]
i8042.c: fa <- i8042 (interrupt-aux) [19]
i8042.c: 00 <- i8042 (interrupt-aux) [19]
i8042.c: 00 <- i8042 (interrupt-aux) [20]
i8042.c: 64 <- i8042 (interrupt-aux) [20]
i8042.c: d4 -> i8042 (command) [20]
i8042.c: f3 -> i8042 (parameter) [20]
i8042.c: 60 -> i8042 (command) [20]
i8042.c: 07 -> i8042 (parameter) [20]
i8042.c: fa <- i8042 (interrupt-aux) [20]
i8042.c: d4 -> i8042 (command) [20]
i8042.c: c8 -> i8042 (parameter) [20]
i8042.c: 60 -> i8042 (command) [20]
i8042.c: 07 -> i8042 (parameter) [20]
i8042.c: fa <- i8042 (interrupt-aux) [20]
i8042.c: d4 -> i8042 (command) [20]
i8042.c: f3 -> i8042 (parameter) [20]
i8042.c: 60 -> i8042 (command) [21]
i8042.c: 07 -> i8042 (parameter) [21]
i8042.c: fa <- i8042 (interrupt-aux) [21]
i8042.c: d4 -> i8042 (command) [21]
i8042.c: 64 -> i8042 (parameter) [21]
i8042.c: 60 -> i8042 (command) [21]
i8042.c: 07 -> i8042 (parameter) [21]
i8042.c: fa <- i8042 (interrupt-aux) [21]
i8042.c: d4 -> i8042 (command) [21]
i8042.c: f3 -> i8042 (parameter) [21]
i8042.c: 60 -> i8042 (command) [21]
i8042.c: 07 -> i8042 (parameter) [21]
i8042.c: fa <- i8042 (interrupt-aux) [22]
i8042.c: d4 -> i8042 (command) [22]
i8042.c: 50 -> i8042 (parameter) [22]
i8042.c: 60 -> i8042 (command) [22]
i8042.c: 07 -> i8042 (parameter) [22]
i8042.c: fa <- i8042 (interrupt-aux) [22]
i8042.c: d4 -> i8042 (command) [22]
i8042.c: f2 -> i8042 (parameter) [22]
i8042.c: 60 -> i8042 (command) [22]
i8042.c: 07 -> i8042 (parameter) [22]
i8042.c: fa <- i8042 (interrupt-aux) [23]
i8042.c: 00 <- i8042 (interrupt-aux) [23]
i8042.c: d4 -> i8042 (command) [23]
i8042.c: f3 -> i8042 (parameter) [23]
i8042.c: 60 -> i8042 (command) [23]
i8042.c: 07 -> i8042 (parameter) [23]
i8042.c: fa <- i8042 (interrupt-aux) [23]
i8042.c: d4 -> i8042 (command) [23]
i8042.c: 64 -> i8042 (parameter) [23]
i8042.c: 60 -> i8042 (command) [24]
i8042.c: 07 -> i8042 (parameter) [24]
i8042.c: fa <- i8042 (interrupt-aux) [24]
i8042.c: d4 -> i8042 (command) [24]
i8042.c: f3 -> i8042 (parameter) [24]
i8042.c: 60 -> i8042 (command) [24]
i8042.c: 07 -> i8042 (parameter) [24]
i8042.c: fa <- i8042 (interrupt-aux) [24]
i8042.c: d4 -> i8042 (command) [24]
i8042.c: c8 -> i8042 (parameter) [24]
i8042.c: 60 -> i8042 (command) [24]
i8042.c: 07 -> i8042 (parameter) [24]
i8042.c: fa <- i8042 (interrupt-aux) [25]
i8042.c: d4 -> i8042 (command) [25]
i8042.c: e8 -> i8042 (parameter) [25]
i8042.c: 60 -> i8042 (command) [25]
i8042.c: 07 -> i8042 (parameter) [25]
i8042.c: fa <- i8042 (interrupt-aux) [25]
i8042.c: d4 -> i8042 (command) [25]
i8042.c: 03 -> i8042 (parameter) [25]
i8042.c: 60 -> i8042 (command) [25]
i8042.c: 07 -> i8042 (parameter) [25]
i8042.c: fa <- i8042 (interrupt-aux) [25]
i8042.c: d4 -> i8042 (command) [25]
i8042.c: e6 -> i8042 (parameter) [25]
i8042.c: 60 -> i8042 (command) [26]
i8042.c: 07 -> i8042 (parameter) [26]
i8042.c: fa <- i8042 (interrupt-aux) [26]
i8042.c: d4 -> i8042 (command) [26]
i8042.c: ea -> i8042 (parameter) [26]
i8042.c: 60 -> i8042 (command) [26]
i8042.c: 07 -> i8042 (parameter) [26]
i8042.c: fa <- i8042 (interrupt-aux) [26]
i8042.c: d4 -> i8042 (command) [26]
i8042.c: f4 -> i8042 (parameter) [26]
i8042.c: 60 -> i8042 (command) [27]
i8042.c: 07 -> i8042 (parameter) [27]
i8042.c: fa <- i8042 (interrupt-aux) [27]
i8042.c: 2d <- i8042 (interrupt-kbd) [9614]
atkbd.c: Received 2d
i8042.c: f0 <- i8042 (interrupt-kbd) [9622]
atkbd.c: Received f0
i8042.c: 2d <- i8042 (interrupt-kbd) [9622]
atkbd.c: Received 2d
i8042.c: 44 <- i8042 (interrupt-kbd) [9689]
atkbd.c: Received 44
i8042.c: f0 <- i8042 (interrupt-kbd) [9698]
atkbd.c: Received f0
i8042.c: 44 <- i8042 (interrupt-kbd) [9698]
atkbd.c: Received 44
i8042.c: 44 <- i8042 (interrupt-kbd) [9707]
atkbd.c: Received 44
i8042.c: f0 <- i8042 (interrupt-kbd) [9718]
atkbd.c: Received f0
i8042.c: 44 <- i8042 (interrupt-kbd) [9718]
atkbd.c: Received 44
i8042.c: 2c <- i8042 (interrupt-kbd) [9744]
atkbd.c: Received 2c
i8042.c: f0 <- i8042 (interrupt-kbd) [9755]
atkbd.c: Received f0
i8042.c: 2c <- i8042 (interrupt-kbd) [9755]
atkbd.c: Received 2c
i8042.c: 5a <- i8042 (interrupt-kbd) [9790]
atkbd.c: Received 5a
i8042.c: f0 <- i8042 (interrupt-kbd) [9803]
atkbd.c: Received f0
i8042.c: 5a <- i8042 (interrupt-kbd) [9803]
atkbd.c: Received 5a
---  snip  --
i8042.c: 1b <- i8042 (interrupt-kbd) [12247]
atkbd.c: Received 1b
i8042.c: f0 <- i8042 (interrupt-kbd) [12263]
atkbd.c: Received f0
i8042.c: 1b <- i8042 (interrupt-kbd) [12263]
atkbd.c: Received 1b
i8042.c: 33 <- i8042 (interrupt-kbd) [12281]
atkbd.c: Received 33
i8042.c: 3c <- i8042 (interrupt-kbd) [12295]
atkbd.c: Received 3c
i8042.c: f0 <- i8042 (interrupt-kbd) [12297]
atkbd.c: Received f0
i8042.c: 33 <- i8042 (interrupt-kbd) [12297]
atkbd.c: Received 33
i8042.c: f0 <- i8042 (interrupt-kbd) [12311]
atkbd.c: Received f0
i8042.c: 3c <- i8042 (interrupt-kbd) [12312]
atkbd.c: Received 3c
i8042.c: 2c <- i8042 (interrupt-kbd) [12319]
atkbd.c: Received 2c
i8042.c: f0 <- i8042 (interrupt-kbd) [12331]
atkbd.c: Received f0
i8042.c: 2c <- i8042 (interrupt-kbd) [12332]
atkbd.c: Received 2c
i8042.c: 23 <- i8042 (interrupt-kbd) [12352]
atkbd.c: Received 23
i8042.c: f0 <- i8042 (interrupt-kbd) [12364]
atkbd.c: Received f0
i8042.c: 23 <- i8042 (interrupt-kbd) [12364]
atkbd.c: Received 23
i8042.c: 44 <- i8042 (interrupt-kbd) [12365]
atkbd.c: Received 44
i8042.c: f0 <- i8042 (interrupt-kbd) [12374]
atkbd.c: Received f0
i8042.c: 44 <- i8042 (interrupt-kbd) [12374]
atkbd.c: Received 44
i8042.c: 1d <- i8042 (interrupt-kbd) [12383]
atkbd.c: Received 1d
i8042.c: 31 <- i8042 (interrupt-kbd) [12396]
atkbd.c: Received 31
i8042.c: f0 <- i8042 (interrupt-kbd) [12399]
atkbd.c: Received f0
i8042.c: 1d <- i8042 (interrupt-kbd) [12399]
atkbd.c: Received 1d
i8042.c: f0 <- i8042 (interrupt-kbd) [12410]
atkbd.c: Received f0
i8042.c: 31 <- i8042 (interrupt-kbd) [12411]
atkbd.c: Received 31
i8042.c: 29 <- i8042 (interrupt-kbd) [12413]
atkbd.c: Received 29
i8042.c: 4e <- i8042 (interrupt-kbd) [12428]
atkbd.c: Received 4e
i8042.c: f0 <- i8042 (interrupt-kbd) [12429]
atkbd.c: Received f0
i8042.c: 29 <- i8042 (interrupt-kbd) [12429]
atkbd.c: Received 29
i8042.c: f0 <- i8042 (interrupt-kbd) [12437]
atkbd.c: Received f0
i8042.c: 4e <- i8042 (interrupt-kbd) [12437]
atkbd.c: Received 4e
i8042.c: 2d <- i8042 (interrupt-kbd) [12491]
atkbd.c: Received 2d
i8042.c: f0 <- i8042 (interrupt-kbd) [12509]
atkbd.c: Received f0
i8042.c: 2d <- i8042 (interrupt-kbd) [12509]
atkbd.c: Received 2d
i8042.c: 29 <- i8042 (interrupt-kbd) [12517]
atkbd.c: Received 29
i8042.c: f0 <- i8042 (interrupt-kbd) [12529]
atkbd.c: Received f0
i8042.c: 29 <- i8042 (interrupt-kbd) [12529]
atkbd.c: Received 29
i8042.c: 31 <- i8042 (interrupt-kbd) [12534]
atkbd.c: Received 31
i8042.c: 44 <- i8042 (interrupt-kbd) [12550]
atkbd.c: Received 44
i8042.c: f0 <- i8042 (interrupt-kbd) [12551]
atkbd.c: Received f0
i8042.c: 31 <- i8042 (interrupt-kbd) [12552]
atkbd.c: Received 31
i8042.c: f0 <- i8042 (interrupt-kbd) [12564]
atkbd.c: Received f0
i8042.c: 44 <- i8042 (interrupt-kbd) [12564]
atkbd.c: Received 44
i8042.c: 1d <- i8042 (interrupt-kbd) [12572]
atkbd.c: Received 1d
i8042.c: f0 <- i8042 (interrupt-kbd) [12587]
atkbd.c: Received f0
i8042.c: 1d <- i8042 (interrupt-kbd) [12588]
atkbd.c: Received 1d
i8042.c: 5a <- i8042 (interrupt-kbd) [12951]
atkbd.c: Received 5a
i8042.c: f0 <- i8042 (interrupt-kbd) [12958]
atkbd.c: Received f0
i8042.c: 5a <- i8042 (interrupt-kbd) [12959]
atkbd.c: Received 5a

