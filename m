Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133110AbREJLmu>; Thu, 10 May 2001 07:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135213AbREJLmk>; Thu, 10 May 2001 07:42:40 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:25900 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S133110AbREJLmd>; Thu, 10 May 2001 07:42:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 Kernel Freeze with highmem BUG at highmem.c:155 - CRASH
Date: Thu, 10 May 2001 13:42:58 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01051013425806.03256@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

After two weeks of quasi stability the server has crashed.. again... with the 
following message... (partial)
------------------
kernel BUG at highmem.c:155

Invalid Operand : 0000
CPU : 1
EIP : 0010:[<c012fcb>]
EFLAGS: 00010286
eax:0000001d ebx: 00000000 esi:c2147ec0
edi: 00000000 ebp: 00001000 esp: df587ebc

Process sshd (pid : 6230, stackpage : df587000)
......
-----------------
This is a standard 2.4.3 kernel with four patches, to correct the 
dcache inode non-clearance (ever growing inode and directory cache) as well 
as the patch to apply vm pressure to lower these caches (Ed Tomlinsons, I 
beleive...).., next patches are for aacraid.. including jens axboes' SCSI 
patch as well as the aacraid patch.

The symptons were an ever more sluggish machine over time, memory usage 
looked pretty standard with the majority of memory assigned to cache... what 
would happen is that at terminal it would go into semi-freeze states of about 
5-10 seconds (increasing with time), where no user interaction was possible. 
By terminal I mean through a ssh remote terminal.... The load would also 
occasionally just increase for no apparent reason to values of 7,8,9...

The server is a dual 933mhz Xeon (PIII) on a ServerWorks Motherboard (HP 
NetServer) with 1.2 gig or ram, 6 SCSI III 18.6 GIG drives in HP Netraid and 
1 9 gig SCSI as the root FS... Running suse 7.0 and reiserfs...

ANy and ALL advice/patches would be greatly appreciated.... I will probably 
be moving back to 2.2 kernel series as a result of my stability problems..

Thanks 
MarCin

-- 
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
-----------------------------
