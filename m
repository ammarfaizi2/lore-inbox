Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268151AbTB1Uk1>; Fri, 28 Feb 2003 15:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268150AbTB1Uk1>; Fri, 28 Feb 2003 15:40:27 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:44003 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268149AbTB1UkY>; Fri, 28 Feb 2003 15:40:24 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Mike Black" <mblack@csi-inc.com>
Date: Sat, 1 Mar 2003 07:49:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15967.52086.864201.674739@notabene.cse.unsw.edu.au>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-raid" <linux-raid@vger.kernel.org>
Subject: Re: RAID SCSI binding
In-Reply-To: message from Mike Black on Friday February 28
References: <015d01c2df23$9c22f020$f6de11cc@black>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday February 28, mblack@csi-inc.com wrote:
> Linux 2.4.20 (but not unique to this kernel -- been this way for over a year):
> I have a RAID5 array that doesn't startup properly during boot (I have to stop it and restart after the system is up).  I've had
> this problem forever and have been trying to fix it.
> Here's what it looks like when it's up and running:
> md4 : active raid5 sdn1[0] sdt1[6] sds1[5] sdr1[4] sdq1[3] sdp1[2] sdo1[1]
>      216490752 blocks level 5, 128k chunk, algorithm 0 [7/7] [UUUUUUU]
> The partitions types are set to 0x83 and the array is being manually
> started in rc.local instead of doing auto-start.

What tool are you using to start the array? raidstart or mdadm?
There doesn't seem to be enough noise in the logs for it to be
raidstart (no "md: autorun ...") so I assume mdadm.

What do you get if you add "-v" to the mdadm running from rc.local?
Can you show me
  mdadm -E /dev/sda1 /dev/sdo1

NeilBrown

> 
> So it looks to me like the md driver doesn't like the raid system crossing the major device boundary for some odd reason.
> Although I'm not sure why I can stop and restart after the system is totally up but not start it in rc.local using the same
> commands:

I suspect this is just a co-incidence.  I cannot imagine how the major
device number could affect things at all.

NeilBrown
