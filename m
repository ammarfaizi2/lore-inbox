Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290823AbSBLILs>; Tue, 12 Feb 2002 03:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290824AbSBLILi>; Tue, 12 Feb 2002 03:11:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14860 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290823AbSBLIL1>;
	Tue, 12 Feb 2002 03:11:27 -0500
Message-ID: <3C68CE00.993721C2@zip.com.au>
Date: Tue, 12 Feb 2002 00:10:40 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Raphael Manfredi <Raphael_Manfredi@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre7 - known issue with ext3?
In-Reply-To: <3057.1013498512@nice.ram.loc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Manfredi wrote:
> 
> I've got the following panic trace on the console this morning:
> 
>  invalid operand: 0000
>  CPU:    0
>  EIP:    0010:[__insert_into_lru_list+28/92]    Not tainted
>  EFLAGS: 00010286
>  eax: 00000000   ebx: 00000002   ecx: cce5ce40   edx: c02b5e94
>  esi: cce5ce40   edi: cce5ce40   ebp: cfa11640   esp: cefb7ea0
>  ds: 0018   es: 0018   ss: 0018
>  Process perl (pid: 14685, stackpage=cefb7000)
>  Stack: 00000002 c012b4c5 cce5ce40 00000002 cce5ce40 00000400 c012b4d5 cce5ce40
>         c012be08 cce5ce40 00001000 00027000 00000000 cfa11640 00000400 00000000
>         c012c357 cfa11640 c1225a80 00000000 00001000 c1225a80 40018000 cfa11640
>  Call Trace: [__refile_buffer+73/80] [refile_buffer+9/16]
>         [__block_commit_write+124/192] [generic_commit_write+51/92]
>         [ext3_commit_write+290/436] [generic_file_write+1184/1720]
>         [ext3_file_write+67/76] [sys_write+142/196] [system_call+51/64]
> 
> Are there known problems with the implementation of ext3 on this kernel, or
> is the root cause elsewhere, and it's only an accident that it was in ext3
> code at the time?
> 

Something corrupted a buffer-head from your freelist.

Please send me your .config and a description of the hardware.
Also a description of what sorts of things the machine is
being used for.  Also please run memtest86 for 12 hours or
more and let me know the results.

Thanks.

-
