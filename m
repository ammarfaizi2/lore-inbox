Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbSLJIi2>; Tue, 10 Dec 2002 03:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSLJIi2>; Tue, 10 Dec 2002 03:38:28 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:48057 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S266708AbSLJIi1> convert rfc822-to-8bit; Tue, 10 Dec 2002 03:38:27 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, dan@debian.org, george@mvista.com,
       jim.houston@ccur.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, ralf@gnu.org, willy@debian.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF363498D8.1AD899BC-ONC1256C8B.002F2E0F@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 10 Dec 2002 09:42:06 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 10/12/2002 09:44:38
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Put the magic restart_block syscall at some fixed place in every
> user process, change the PC to that.  Or, alternatively, put the
> restart_block syscall insn on the stack and point the PC at that.
>
> This isn't rocket science :-)

Something like that was my first though as well. I would have played
games with return addresses inside the kernel instead of user space.
The idea to have another _TIF_xxx flag seems much cleaner though and
I want the cleanest solution for this. Once this is implemented every
system call can be restarted with a different system call number. Who
knows what other uses this might have?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


