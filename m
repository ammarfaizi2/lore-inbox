Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315750AbSEJBSg>; Thu, 9 May 2002 21:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315751AbSEJBSf>; Thu, 9 May 2002 21:18:35 -0400
Received: from firewall.teleholding.com ([64.46.90.130]:33012 "EHLO
	mail.teleholding.com") by vger.kernel.org with ESMTP
	id <S315750AbSEJBSe> convert rfc822-to-8bit; Thu, 9 May 2002 21:18:34 -0400
Message-ID: <3CDB1FFD.90703@teleholding.com>
Date: Thu, 09 May 2002 20:18:53 -0500
From: Henrik Mitsch <hmitsch@teleholding.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Henrik Mitsch <hmitsch@teleholding.com>
Subject: kernel panic, 2.4.7 (Redhat 7.2) and i don't know why
X-MIMETrack: Itemize by SMTP Server on thserver/Teleholding(Release 5.0.9a |January 7, 2002) at
 05/09/2002 08:27:35 PM,
	Serialize by Router on thserver/Teleholding(Release 5.0.9a |January 7, 2002) at
 05/09/2002 08:27:41 PM
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[initially i posted this message to linux.kernel until i found out that 
this was a mailinglist-to-newsgroup thing. so i think the message never 
reached the list and it is okay to repost this message.]

Dear linux kernel mailing list,

our company has an IBM netfinity 866 MHz server with two IBM 30 GB SCSI
disks doing a RAID-1 (mirroring). the machine is running Redhat 7.2
(kernel  2.4.7-10).

when i set up the machine in january i suspected a hardware damage on
one of the two HDDs. IBM checked and returned me the _same_ disks saying
they were okay (i don't know if they fixed anything).

after this the server crashed about once in every 30 days (in total
three times). yesterday it crashed again (the UPS ran out of power due
to a failure in the public electricity network). i booted as usual but
within the next two hours the server kept on crashing (in total four
times).

the register dump was very similar each time. i checked at Google but
could not find anything. maybe somebody can clear things up?

esi: d083a000 edi: 00000000 ebp: 00000000 esp: c0257bec
ds: 0018 es: 0018 ss:0018
Process swapper (pid:0, stackpage=c0257000)
[stack contents, etc]
Code: 8b 07 0f b6 40 19 eb 05 b8 ff 00 00 00 50 31 ff 6a ff 55 0f
<0> Kernel panic: Aiee, killing interrupt handler!
Interrupt handler - not synching

the esi, edi, ebp, esp contents was the same in two crashes (yesterday).
ds, es, ss, process swapper and code were the same in all four crashes
(yesterday).

i have no idea what all these numbers mean. :-(

as a quick fix i took out the SCSI disk i (still) suspect to be damaged.
since then we did not have any problems. but the server is only up for
19 hours so i don't know what is yet to come ...

could you recommend me how to test the other HDD for errors? i am not
really familiar with filesystem check issues in Linux.

i really hope somebody has some kind of answers or advice how to handle
this problem.

btw, could you please send a CC to my email address as i am not 
subscribed to the kernel mailing list. thank you.

greetings from Quito,
	
	Henrik Mitsch

-- 
Teleholding S.A. - http://www.teleholding.com
Departamento de Proyectos
Email: hmitsch@teleholding.com
Teléfono: (593 2) 2560 600 - 125
Beeper: (02) 2555 000 (a nombre de: Teleholding - Henrik Mitsch)

