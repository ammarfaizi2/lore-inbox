Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSE2Aiz>; Tue, 28 May 2002 20:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSE2Aiy>; Tue, 28 May 2002 20:38:54 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:13008 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S312938AbSE2Aiy>; Tue, 28 May 2002 20:38:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: kwijibo@zianet.com
Date: Wed, 29 May 2002 10:38:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15604.8977.85448.884592@notabene.cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Software RAID/Filesystem problems?
In-Reply-To: message from kwijibo@zianet.com on Tuesday May 28
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 28, kwijibo@zianet.com wrote:
> Hello,
> 
> I have run into a problem with software raid with large filesystems.
> I am not sure if this is a software raid limitation or a filesystem
> limitation.  I currently have two 3ware raid controllers that have
> 1.1TB (yes, terrabyte) of space on each.  I want to stripe the two
> hardware raid controllers using software raid but when I try to make
> the raid using the command mkraid /dev/md0 it pukes out this:

sorry.  No-Can-Do.  Not in 2.4 anyway.  Maybe in 2.6...

2 time 1.1TB > 2TB.

2TB is the most you can access with 32bits addressing for 512byte
sectors.

You are hitting an error at (1K) block 134217729 which is 1 block past
2TB.

If you make the sdb1 and sdc1 partitions less than 1TB you have a
better change of it working.

NeilBrown
