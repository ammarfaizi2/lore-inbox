Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285285AbRLSN3k>; Wed, 19 Dec 2001 08:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285286AbRLSN3c>; Wed, 19 Dec 2001 08:29:32 -0500
Received: from jack.see.plymouth.ac.uk ([141.163.168.57]:12301 "EHLO
	jack.see.plym.ac.uk") by vger.kernel.org with ESMTP
	id <S285285AbRLSN30>; Wed, 19 Dec 2001 08:29:26 -0500
Message-ID: <3C2094D2.9010506@jack.see.plym.ac.uk>
Date: Wed, 19 Dec 2001 13:23:30 +0000
From: "George B. Magklaras" <semaphore@jack.see.plym.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010917
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thodoris Pitikaris <linux@iesl.forth.gr>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem with smb
In-Reply-To: <3C208B2A.5070803@iesl.forth.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thodoris Pitikaris wrote:

> Hi,
>
> In our institute we have a cluster system with 6 sytems that have the 
> following
> configuration :
>
> CPU: PIII 1GHZ/133 MHZ (DUAL)
> MOTHER: Intel Server Board STL2 (intergrated Intel pro/100+ & Adaptec 
> Ultra 160 SCSI) Chipset ServerWorks OSB4
> NET CARD: 3COM Broadcom BCM5700 (Gigabit)
> RAID Cont. : AMI MegaRAID (only in PBS server)
> HDD: IBM       Model: DDYS-T18350N
> MEMORY: 512MB/133Mhz
> OS: REDHAT 7.1 with Default Kernel (2.4.7)
>
> What the problem is : The PBS server after some time freeze, with no 
> error message from kernel Just freeze. We have changed everthing (even 
> the tower)
> but nothing happened !
>
> Is there any sugestions ?
>
> Best Regards
>
> --thodoris
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
Theodore,

You have to be a little bit more specific. You perceive that the PBS 
freezes. Obviously this means that console access is completely 
disabled. But are you sure that you can't for example ping the box, when 
console access is impossible? Also you might not see any messages on the 
console, but what about the /var/log files?

The hardware info is relevant, but can you also include the output of:


1)dmesg (After a reboot)
2)tail -300 /var/log/messages
3)modprobe -c
4)uname -a
5) cat /proc/pci
5)Write a script that will frequently execute the output of 'vmstat 3' 
to a file and then when the box crashes, reboot and include the file in 
your e-mail. This can help people track down something peculiar that 
happens just before the box dies?

Then people that can help will take it from there...
 
Regards,

-- 
George B. Magklaras BSc Hons CLE
Computer Security Researcher
The Network Research Group (http://ted.see.plymouth.ac.uk/nrg)
University of Plymouth, Devon, UK
Tel: +44-1752-233520

--
Personal URL: http://tornado.see.plym.ac.uk




