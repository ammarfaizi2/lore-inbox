Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318383AbSICP0b>; Tue, 3 Sep 2002 11:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318787AbSICP0b>; Tue, 3 Sep 2002 11:26:31 -0400
Received: from mx.nlm.nih.gov ([130.14.22.48]:22737 "EHLO mx.nlm.nih.gov")
	by vger.kernel.org with ESMTP id <S318383AbSICP0a>;
	Tue, 3 Sep 2002 11:26:30 -0400
Message-ID: <3D74D590.5A8D6A5B@ncbi.nlm.nih.gov>
Date: Tue, 03 Sep 2002 11:30:24 -0400
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Organization: NCBI NIH
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: vakatov@ncbi.nlm.nih.gov, linux-kernel@vger.kernel.org,
       torvalsd@transmeta.com
Subject: Re: BUG:: SYSV IPC shmem reported as "(deleted)" in process mapsfile
References: <Pine.LNX.4.33.0208311329390.21191-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> > /proc/#/maps file of a process, which has a shared memory segment attached,
> > prints the segment as "(deleted)" while in fact the segment is fine and sound.
> > This seems to be quite confusing.
> 
> perhaps to some.  on the other hand, it is deleted - a file that has no
> entry in any FS namespace.  what would you suggest as an alternative?
> 
> > cat /proc/#/maps:
> > 40018000-40022000 rw-s 00000000 00:05 5865476    /SYSV01315549 (deleted)

I would suggest to state such kind of mapping quite straightforward - as IPC shmem
(not as generic FS-like notation, which might be useful, but like I said, still
looks confusing), and to provide "(deleted)" only if the segment was actually
removed (from SYSV IPC point of view).
