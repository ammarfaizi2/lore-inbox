Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130785AbQKKNux>; Sat, 11 Nov 2000 08:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130788AbQKKNuo>; Sat, 11 Nov 2000 08:50:44 -0500
Received: from limes.hometree.net ([194.231.17.49]:26912 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S130791AbQKKNuc>; Sat, 11 Nov 2000 08:50:32 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Nov 2000 13:40:42 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <8uji8q$1ru$1@forge.tanstaafl.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org>, <3A0C6E01.EFA10590@timpanogas.org>
Reply-To: hps@tanstaafl.de
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@timpanogas.org (Jeff V. Merkey) writes:


>We got to the bottom of the sendmail problem.  The line:

> -O QueueLA=20 

>and

> -O RefuseLA=18

>Need to be cranked up in sendmail.cf to something high since the
>background VM on a very busy Linux box seems to exceed this which causes
>large emails to get stuck in the /var/spool/mqueue directory for long
>periods of time.  Since vger is getting hammered with FTP all the time,
>and is rarely idle.  This also explains what Richard was seeing with VM
>thrashing in a box with low memory.  

So what? This is written in the documentation of the program? You do read
documentation, do you?

>The problem of dropping connections on 2.4 was related to the O RefuseLA
>settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
>clearly set too low for modern Linux kernels.  You may want them cranked
>up to 100 or something if you want sendmail to always work.  

These settings are for single user / small user numbers boxes.

If you're using an out of the vendor box distribution configuration
for a high traffic server, you're nuts. Or ignorant. Or dumb. Or your
consultant is an idiot.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
