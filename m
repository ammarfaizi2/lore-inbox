Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282139AbRKWNJv>; Fri, 23 Nov 2001 08:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282140AbRKWNJm>; Fri, 23 Nov 2001 08:09:42 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:18892 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S282139AbRKWNJc>; Fri, 23 Nov 2001 08:09:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: hari <harisri@bigpond.com>
To: Samium Gromoff <_deepfire@mail.ru>
Subject: Re: Heavy disk IO stalls ftp/http downloads
Date: Sat, 24 Nov 2001 00:12:41 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111231132.fANBWbk11468@vegae.deep.net>
In-Reply-To: <200111231132.fANBWbk11468@vegae.deep.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011123130935Z282139-17408+17818@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001 11:32, Samium Gromoff wrote:
>         does hdparm -u1 fixes the problem?
>        -u1 == unmasq irq during its handling
>     the problem is that serial port need its interrupt to be served with
> minimal latency, and the drives makes that impossible, unless irqs are
> unmasked...
Hello Samium,

Thanks a lot for your response.

Yes, I have -u1 support enabled for both the hard drives (in fact it is 
/sbin/hdparm -m16 -c3 -u1 -X66 -d1 -W1 /dev/hda and /dev/hdc). But, 
unfortunately it does not fix the problem.

Here is the 'hdparm' output from the hard drives:
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1247/255/63, sectors = 20044080, start = 0

/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1240/255/63, sectors = 19931184, start = 0
-- 
Hari.
harisri@bigpond.com
