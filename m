Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTCCPMp>; Mon, 3 Mar 2003 10:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTCCPMp>; Mon, 3 Mar 2003 10:12:45 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:52241 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265424AbTCCPMm>; Mon, 3 Mar 2003 10:12:42 -0500
Message-Id: <200303031513.h23FCkr29308@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: wyleus <coyote1@cytanet.com.cy>
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Date: Mon, 3 Mar 2003 17:10:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: redelm@ev1.net, john@grabjohn.com, linux-kernel@vger.kernel.org
References: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy> <200302280645.h1S6ims00404@Port.imtp.ilyichevsk.odessa.ua> <20030301082126.56c00418.coyote1@cytanet.com.cy>
In-Reply-To: <20030301082126.56c00418.coyote1@cytanet.com.cy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 March 2003 15:21, wyleus wrote:
> Friday, Feb 28 2003
> Results of burnMMX tests
>
> command: burnMMX x;  echo $?
>
> where x represents memory size parameter passed to burnMMX as
> follows;
>
> <small excerpt from cpuburn readme>
> burnBX and burnMMX are essentially very intense RAM testers.  They
> can also take an optional parameter indicating the RAM size to be
> tested:
>
>   A =  2 kB   E =  32 kB   I = 512 kB   M =  8 MB
>   B =  4      F =  64      J =   1 MB   N = 16
>   C =  8      G = 128      K =   2      O = 32
>   D = 16      H = 256      L =   4      P = 64
>
> the default memsize used when none is specified is F=64k
>
> exit codes for burnMMX are as follows;
> 130 = process killed manually using ctl-c
> 254 = integer/memory error
> 255 = FP/MMX error
>
> mem		runtime		exit
> size    	(minutes) 	code
>
> A (2K)		26:00		130
> 		28:15		130
> F (64K)		2:00		254
> 		11:00		130
> 		6:00		130
> 		21:42		130
> G (128K)	6:00		130
> H (256K)	3:25		254
> 		2:40		254
> 		0:45		254	1 these
> 		1:35		254	1 are
> 		0:40		254	1 consecutive
> 		3:45		254	1 runs
> 		33:00		130	1
> 		7:00		254	1
> 		7:00		254	1
> 		5:16		254	1
> 		17:19		254	1
> I (512K)	6:00		254
> 		1:48		254
> 		5:34		254
>
> Sat, March 1, 2003
>
> Switched the RAM stick from the first slot (closest
> to CPU), to the middle slot;
>
> command: time burnMMX x; echo $?
>
> (using the time command, manual exits using
> ctl-c provide exit code 2, but I still list it
> here as 130 in the table for consistency)
>
> mem		runtime		exit
> size    	(minutes) 	code
>
> G (128K)	2:46		254
> 		21:50		130
> H (256K)	20:12		130
> 		33:46		130
> I (512K)	20:06		130
> 		21:58		130
> J (1024K)	21:57		130
>
> Only one error so far after 7 runs, which seems much better than
> before, but still unnacceptable I guess...
>
> Where should I go from here?  Try another slot?  Buy new RAM?  More
> testing?

You should underclock and/or overvolt your system until it runs these
tests stably.
--
vda

