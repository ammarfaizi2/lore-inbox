Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277704AbRJICmu>; Mon, 8 Oct 2001 22:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277705AbRJICml>; Mon, 8 Oct 2001 22:42:41 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:47755 "HELO linking.ee")
	by vger.kernel.org with SMTP id <S277704AbRJICm1>;
	Mon, 8 Oct 2001 22:42:27 -0400
Message-ID: <35766.10.110.0.21.1002596153.squirrel@mail.linking.sise>
Date: Tue, 9 Oct 2001 04:55:53 +0200 (EET)
Subject: BUG: Memory usage, 2.4.10 meaning of "free" and cached.
From: "Elmer Joandi" <elmer@linking.ee>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_?hOe4ym7uCUUmuF/Ihy2ac+g'JRBhu6Lcs6I93'8k6_1+.9Kt((9d7+PLMc6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------=_?hOe4ym7uCUUmuF/Ihy2ac+g'JRBhu6Lcs6I93'8k6_1+.9Kt((9d7+PLMc6
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit


About 1 G of RAM
Squid, mysql, bunch of other daemons and programs  configured to take about 500MB(lots of 
chroot boxes).
/tmp 's  mounted as tmpfs

With 2.4.2-ac28(also tmpfs) there was 500MB cached(or somethimes on random occasions 
lots of buffered). And swap being used, 300MB after pushing the computer to swap.

Now, with 2.4.10....

	There is everything used (only 120M cached, 5M buffered) ,exept swap(10M),
	When starting applications like soffice,mozilla and other hogs, the cached number 
	... grows...(and free degrades a bit if it is free at particular moment).
	hovever, numbers of memory usage are much higher than with 2.4.2-ac28
	stoping hogs gives us some free memory (looks like someone installed RAM on the fly 
	:) (not total of it, of course :) ) )
	
	Now, taking a 300MB file with joe, opening it... the cached grows(probably as joe 
		makes temporary on tmpfs), swap usage grows minimally.
	Quiting joe... free grows (but swap is still used minimally, 13M) and now there is plenty 
	of free and lots of cached(i.e. same amount of programs and memory used by 	
	applications, but, compared to start, there has come about some hundred megs of free 
	memory 	from somewhere)

1. It seems that the meaning of "free" or "free+cached+buffered" in top has changed over the 
time a bit ? It seems that all of cached is not reported as cached, and after stressing memory 
and freeing those hidden cached there is more "free+cached+buffered" at the end of 
memory-stressing programs run despite that no other programs have released any signifficant 
amount of memory.
2. How to tell kernel to use swap more agressively ?



------=_?hOe4ym7uCUUmuF/Ihy2ac+g'JRBhu6Lcs6I93'8k6_1+.9Kt((9d7+PLMc6
Content-Type: application/octet-stream;name=""
Content-Disposition: attachment; filename=""
Content-Transfer-Encoding: base64

DQo=

------=_?hOe4ym7uCUUmuF/Ihy2ac+g'JRBhu6Lcs6I93'8k6_1+.9Kt((9d7+PLMc6--

