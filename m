Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261396AbTCTOfA>; Thu, 20 Mar 2003 09:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261488AbTCTOfA>; Thu, 20 Mar 2003 09:35:00 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:19082 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S261396AbTCTOe7>; Thu, 20 Mar 2003 09:34:59 -0500
Date: Thu, 20 Mar 2003 07:45:58 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Christoph Baumann <cb@sorcus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace patch
In-Reply-To: <001d01c2eeeb$02112b00$2265a8c0@dirtyentw>
Message-ID: <Pine.LNX.4.51.0303200743050.25830@skuld.mtroyal.ab.ca>
References: <001d01c2eeeb$02112b00$2265a8c0@dirtyentw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, Christoph Baumann wrote:

> FYI:
> The ptrace patch at
> http://www.hardrock.org/kernel/2.4.20/linux-2.4.20-ptrace.patch does not
> seem to work.
> I tried the exploit at http://sinuspl.net/ptrace/isec-ptrace-kmod-exploit.c
> on a machine running the patched kernel and it still brought up a root
> shell.

Hi,
Here is a test:

bash$ md5sum isec-ptrace-kmod-exploit.c 
f3a5c17bf8d207d3f4828020d1bcfa0a  isec-ptrace-kmod-exploit.c
bash$ make isec-ptrace-kmod-exploit   
cc     isec-ptrace-kmod-exploit.c   -o isec-ptrace-kmod-exploit
bash$ ./isec-ptrace-kmod-exploit 
[-] Unable to attach: Operation not permitted
Killed
bash$ id
uid=151(myusername)
gid=151(myusername)
groups=151(mygrpname)
bash$ uname -a
Linux myhostname 2.4.20-9-PE2650-6650 #1 SMP Mon Mar 17 11:22:15 MST 2003 i686 unknown
bash$ 

Thankfully it does work.

Check your binary for suid root.

Regards,
James Bourne

> 
> 
> Mit freundlichen Gruessen / Best regards
> Dipl.-Phys. Christoph Baumann
> ---
> SORCUS Computer GmbH
> Im Breitspiel 11 c
> D-69126 Heidelberg
> 
> Tel.: +49(0)6221/3206-0
> Fax: +49(0)6221/3206-66
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."

