Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263006AbTCLD04>; Tue, 11 Mar 2003 22:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263007AbTCLD04>; Tue, 11 Mar 2003 22:26:56 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:11153 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263006AbTCLD0z>; Tue, 11 Mar 2003 22:26:55 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: scott-kernel@thomasons.org
Date: Wed, 12 Mar 2003 14:37:29 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15982.43897.703221.456961@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
In-Reply-To: message from scott thomason on Tuesday March 11
References: <200303112055.31854.scott-kernel@thomasons.org>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 11, scott-kernel@thomasons.org wrote:
> I frequently receive this message in my syslog, apparently 
> whenever there are periods of significant write activity:
> 
>     bio too big device ide0(3,7) (256 > 255)
>     bio too big device ide1(22,6) (256 > 255)
> 
> It's worth noting that on this system I have had ongoing trouble 
> with system stability during write activity as well, using a 
> wide variety of 2.5.x kernels, even though at the time of this 
> symptom things are apparently running fine.
> 
> Filesystems are all ext3 on top soft raid0 devices. This happens 
> to be 2.5.64, but it has been happening for at least the last 
> 5-6 versions.
> 
> Ideas? Any further debugging output I can provide?


raid0 doesn't really work well in 2.5 yet.... as you have noticed.

We really need to grab the bio splitting code out of md/dm.c and use
it to split bios that are too big or that cross device boundaries.

any volunteers??

NeilBrown
