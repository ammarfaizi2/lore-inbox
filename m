Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318852AbSG0W45>; Sat, 27 Jul 2002 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318853AbSG0W45>; Sat, 27 Jul 2002 18:56:57 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:62922 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318852AbSG0W44>; Sat, 27 Jul 2002 18:56:56 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Austin Gonyou" <austin@digitalroadkill.net>,
       <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Ville Herva" <vherva@niksula.hut.fi>, "DervishD" <raul@pleyades.net>,
       "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sat, 27 Jul 2002 16:01:05 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECCEPJCPAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1027814596.21511.5.camel@irongate.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why would you want to push *anything* to swap until you have to?

>To reduce the amount of disk access

So in Solaris, the scanner is going to eventually wake up as long as your
doing filesystem I/O, it's just a question of how long it takes to reach
lotsfree.
During that time it caches anything and everything in physical memory.
Are you implying that it should be looking for pages to swap out this whole
time to free up more space for filesystem and executable pages purely based
on lru? Have you done testing to prove that this is a better approach than
setting a threshold of when to wake up the lru mechanism?

>> Dirty filesystem pages have to be flushed to disk, it's just a question
of

>Clean ones do not. Dirty ones are also copied to disk but remain in
>memory for reread events. They may also be deleted before being written.

Solaris keeps dirty pages after they have been flushed to their backing
store, it's just when the system has to choose something to flush that it
preferences filesystem over anonymous and executable, what's wrong with
that?


>> and it's pretty relative what "long unaccessed" means ..

>In the Linux case the page cache is basically not discriminating too
>much about what page is (and it may be several things at once - cache,
>executing code and file data) just its access history.

Interesting ...


