Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSH3VLa>; Fri, 30 Aug 2002 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319664AbSH3VLa>; Fri, 30 Aug 2002 17:11:30 -0400
Received: from mx.nlm.nih.gov ([130.14.22.48]:51427 "EHLO mx.nlm.nih.gov")
	by vger.kernel.org with ESMTP id <S317571AbSH3VL3>;
	Fri, 30 Aug 2002 17:11:29 -0400
Message-ID: <3D6FE07C.B76DD4B6@ncbi.nlm.nih.gov>
Date: Fri, 30 Aug 2002 17:15:40 -0400
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Organization: NCBI NIH
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linus@transmeta.com
CC: vakatov@ncbi.nlm.nih.gov
Subject: Re: BUG:: SYSV IPC shmem reported as "(deleted)" in process maps file
References: <3D6FDFF8.C0D86A3C@ncbi.nlm.nih.gov>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developers:

/proc/#/maps file of a process, which has a shared memory segment attached,
prints the segment as "(deleted)" while in fact the segment is fine and sound.
This seems to be quite confusing.

cat /proc/#/maps:
40018000-40022000 rw-s 00000000 00:05 5865476    /SYSV01315549 (deleted)
4021b000-40225000 rw-s 00000000 00:05 5898248    /SYSV012cc3bc (deleted)

ipcs -a:
0x01315549 5865476    ncbiduse  666        40960      1
0x012cc3bc 5898248    ncbiduse  666        40960      1

Best regards,

Anton Lavrentiev
NCBI/NLM/NIH
Bethesda MD 20894
