Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRLDDns>; Mon, 3 Dec 2001 22:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283085AbRLCXpq>; Mon, 3 Dec 2001 18:45:46 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:16649 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S284498AbRLCMPE>; Mon, 3 Dec 2001 07:15:04 -0500
Subject: filling up pt_regs by  myself
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: debian-alpha <debian-alpha@lists.debian.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 03 Dec 2001 17:45:30 +0530
Message-Id: <1007381730.1800.14.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

 Is there any functions that i can use to setup pt_regs structure
myself. 

For example how can I take a following  i386 system call  to alpha 

 sys_mycall( struct pt_regs regs)
{
	my_function( &regs);

}

I tried to do it same way . But then the value of members of  regs
structure  that i am  getting are corrupted. Later looking into the
source i found that for most of  alpha  system call is defined something
like 

 sys_mycall( arg1, arg2, arg3.....)

So i replaced the above function definition with 

 sys_mycall( argument1, argument 2 argument ) here consider  it takes
only three arguments ... 

But now how i will pass the regs structure to my_function . Is there any
already existing function that help me to do that something like
save_regs(&regs) ? Or do i need to hand code all the saving by itself.
Can I use SAVE_ALL #define defined in entry.S .

Thanks in advance . 

 -aneesh 
  



