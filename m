Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311593AbSCXReU>; Sun, 24 Mar 2002 12:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311594AbSCXReK>; Sun, 24 Mar 2002 12:34:10 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:29449
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S311593AbSCXRd7>; Sun, 24 Mar 2002 12:33:59 -0500
Message-Id: <5.1.0.14.2.20020324122756.02581750@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 24 Mar 2002 12:28:48 -0500
To: Alexander Viro <viro@math.psu.edu>, rddunlap@osdl.org
From: Stevie O <stevie@qrpff.net>
Subject: Re: [patch 2.5] seq_file for /proc/partitions
Cc: linux-kernel@vger.kernel.org, davej@suse.de
In-Reply-To: <Pine.GSO.4.21.0203232308260.6560-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:11 PM 3/23/2002 -0500, Alexander Viro wrote:
>> +     return part_start(part, pos);
>
>Erm...  Actually that _is_ wrong - what you want is
>
>        return ((struct gendisk)v)->next;

Forgive my ignorance, but that doesn't look right....
shouldn't it REALLY be

        return ((struct gendisk*)v)->next;


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

