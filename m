Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312901AbSDGBfP>; Sat, 6 Apr 2002 20:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312899AbSDGBfO>; Sat, 6 Apr 2002 20:35:14 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:29637 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S312901AbSDGBfN>; Sat, 6 Apr 2002 20:35:13 -0500
Date: Sat, 06 Apr 2002 17:35:37 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <1759693825.1018114535@[10.10.2.3]>
In-Reply-To: <E16tuQV-0002Lt-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 1. Are there tables that are created by the BIOS that we 
>> destroy during Linux runtime? mps tables spring to mind - 
>> I can't see where we preserve them ...
> 
> They should be in E820 reserved pages anyway and we do keep them 
> and the EBDA safe. 

Ah, OK. I will have to check the BIOS is doing this correctly,
since I hacked it to move the MPS tables to a different place
(below 8Mb). I should really fix that using a fixmap or something
anyway ...

> You will however have blown away ACPI pages marked as disposable

Pah, ACPI ;-) I don't have ACPI on these machines, but it would
be needed for a more general solution - sounds easy enough to fix 
anyway - we just keep them and mark them reserved during the Linux
ACPI parse, I think.

Thanks,

M.

