Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAICDb>; Mon, 8 Jan 2001 21:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAICDW>; Mon, 8 Jan 2001 21:03:22 -0500
Received: from inje.iskon.hr ([213.191.128.16]:23817 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S129226AbRAICDE>;
	Mon, 8 Jan 2001 21:03:04 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.21.0101071919120.21675-100000@duckman.distro.conectiva>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 09 Jan 2001 03:01:52 +0100
In-Reply-To: Rik van Riel's message of "Sun, 7 Jan 2001 19:37:06 -0200 (BRDT)"
Message-ID: <87y9wlh4a7.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> Now if 2.4 has worse _performance_ than 2.2 due to one
> reason or another, that I'd like to hear about ;)
> 

Oh, well, it seems that I was wrong. :)


First test: hogmem 180 5 = allocate 180MB and dirty it 5 times (on a
192MB machine)

kernel | swap usage | speed
-------------------------------
2.2.17 |  48 MB     | 11.8 MB/s
-------------------------------
2.4.0  | 206 MB     | 11.1 MB/s
-------------------------------

So 2.2 is only marginally faster. Also it can be seen that 2.4 uses 4
times more swap space. If Linus says it's ok... :)


Second test: kernel compile make -j32 (empirically this puts the VM
under load, but not excessively!)

2.2.17 -> make -j32  392.49s user 47.87s system 168% cpu 4:21.13 total
2.4.0  -> make -j32  389.59s user 31.29s system 182% cpu 3:50.24 total

Now, is this great news or what, 2.4.0 is definitely faster.

-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
