Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276451AbRJKPYN>; Thu, 11 Oct 2001 11:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276527AbRJKPYD>; Thu, 11 Oct 2001 11:24:03 -0400
Received: from mail.spylog.com ([194.67.35.220]:13532 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S276534AbRJKPXp>;
	Thu, 11 Oct 2001 11:23:45 -0400
Date: Thu, 11 Oct 2001 19:20:09 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <58528703605.20011011192009@spylog.com>
To: Cliff Albert <cliff@oisec.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: 2.4.11aa1 and AIC7XXX
In-Reply-To: <20011011163105.A18508@oisec.net>
In-Reply-To: <13522687985.20011011173954@spylog.com>
 <20011011163105.A18508@oisec.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, Cliff and all,

Thursday, October 11, 2001, 6:31:05 PM, you wrote:

CA> On Thu, Oct 11, 2001 at 05:39:54PM +0400, Oleg A. Yurlov wrote:

>> Oct 10 20:35:31 samson kernel: (scsi0:A:2:0): Locking max tag count at 128
>> Oct 10 21:06:31 samson kernel: (scsi1:A:0:0): Locking max tag count at 64                                                           
>> Oct 11 05:33:09 samson kernel: (scsi0:A:3:0): Locking max tag count at 128       
>> 
>>         Hardware   -  SMP 2 CPU, 1GB RAM, M/B Intel L440GX, 5 SCSI HDD, Software
>> RAID5 (3 disks) and RAID1.
>> 
>>         I found in dmesg:
>> 
>>  *** Possibly defective BIOS detected (irqtable)
>>  *** Many BIOSes matching this signature have incorrect IRQ routing tables.
>>  *** If you see IRQ problems, in paticular SCSI resets and hangs at boot
>>  *** contact your vendor and ask about updates.
>>  *** Building an SMP kernel may evade the bug some of the time.
>> Starting kswapd
>> 
>>         It's  normal or not ? What I can do to fix problem with locking max tag
>> count ?

CA> Looks normal, it's that the new aic7xxx driver utilizes a maximum tag queue depth of 255 tags. Your devices are supporting only a maximum tag count of 128, 64 and 128 so it's perfectly normal.
CA> Also these 'error' messages should only appear once and no more (until a reboot)

        Thanks a lot !

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

