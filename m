Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270102AbRHQKZj>; Fri, 17 Aug 2001 06:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270101AbRHQKZ3>; Fri, 17 Aug 2001 06:25:29 -0400
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:19959 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270090AbRHQKZT>; Fri, 17 Aug 2001 06:25:19 -0400
Message-ID: <3B7CF060.D3E1F6B5@didntduck.org>
Date: Fri, 17 Aug 2001 06:22:24 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Nord <teilo@cdt.luth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: K6 sig11 Bug detection.
In-Reply-To: <3B7CEE40.90100@cdt.luth.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nord wrote:
> 
> Hi,
> 
> I have a Debian based system with a custom 2.4.7 kernel compiled with
> gcc version 2.95.4 20010703 (Debian prerelease)
> (also saw the same with 2.2.10+ gcc 2.95)
> 
> The CPU in the machine is a AMD K6 200MHz, and has 64MB of SDRAM
> 
> I reomved the heatsink and the serial is Cxxxxxxxx, however in the
> kernel boot messages I get the following,
> 
> Aug 17 09:06:49 phoenix kernel: CPU: Before vendor init, caps: 008001bf
> 008005bf 00000000, vendor = 2
> Aug 17 09:06:49 phoenix kernel: AMD K6 stepping B detected - <6>K6 BUG
> 9016725 20000000 (Report these if test report is incorrect)
> Aug 17 09:06:49 phoenix kernel: AMD K6 stepping B detected - probably OK
> (after B9730xxxx).
> Aug 17 09:06:49 phoenix kernel: Please see
> http://www.mygale.com/~poulot/k6bug.html
> Aug 17 09:06:49 phoenix kernel: CPU: L1 I Cache: 32K (32 bytes/line), D
> cache 32K (32 bytes/line)
> Aug 17 09:06:49 phoenix kernel: CPU: After vendor init, caps: 008001bf
> 008005bf 00000000 00000000
> Aug 17 09:06:49 phoenix kernel: CPU:     After generic, caps: 008001bf
> 008005bf 00000000 00000000
> Aug 17 09:06:49 phoenix kernel: CPU:             Common caps: 008001bf
> 008005bf 00000000 00000000
> Aug 17 09:06:49 phoenix kernel: CPU: AMD-K6tm w/ multimedia extensions
> stepping 01
> 
> Is the stepping not the first part of the serial? I have 64MB (the
> amount that triggers the bug IIRC) in the system and the the kernel and
> everything else compiles without generating a SIG11.
> 
> Is this a false detection or would it be possible that I have a wrongly
> tagged CPU?
> 
> Also the link http://www.mygale.com/~poulot/k6bug.html does not exist.
> 
> Please CC replies to me as I am not on the list.

You have a later B step CPU with that bug fixed.  Otherwise you would
have seen "system stability may be impaired when more than 32 MB are
used." in the logs.  For some reason, AMD didn't bump the stepping when
they fixed that bug.

-- 

						Brian Gerst
