Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVC1T3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVC1T3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVC1T3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:29:13 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:38080 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S262005AbVC1T3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:29:06 -0500
Date: Mon, 28 Mar 2005 22:29:01 +0300
From: Ville Herva <vherva@vianova.fi>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems
Message-ID: <20050328192901.GD5470@viasys.com>
Reply-To: vherva@vianova.fi
References: <20050326162801.GA20729@logos.cnet> <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com> <20050328172558.GU30052@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328172558.GU30052@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.vianova.fi 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 07:25:58PM +0200, you [Willy Tarreau] wrote:
> 
> Since you don't seem to be willing to remove vserver, I guess you really
> need it on this machine, and to be honnest, 

Yes, the machine is in production, and for that it, it needs vserver. The
fact it is in production also makes it a tad hankala awkward to test
different options, at least the most experimental ones.

> I too don't see what trouble it could cause in this area. 

Neither do I. Of course it could be memory corruption caused by vserver in
different part of kernel, but the fact that the symptoms are so consistent,
make me think that is unlikely. But not impossible.

> However, could you try removing the journal, or simply mount the FS as
> ext2 ? It would help to narrow the problem down.

That is a good idea, if only I could boot the box at will and reliably
reproduce the problem. While it took less than ten minutes to trigger it the
first time, it took more than five hours the first time. 

I will try to reproduce the problem on different setup first, and if I can
do that, I'll try your suggestion.
 
> To resume, you have your root on ext3 on top of soft raid1 consisting in
> two IDE disks, which works in 2.4.21 but not on 2.4.30-rc3, that's
> correct ? 

Correct. This is PII 266MHz, no SMP.

> There was a fix last week by Neil Brown about RAID1 rebuild process
> (degraded array of 3 disks, etc...), unless it obviously does not come
> from there, you might want to try reverting it first ? 

Sounds sane, although the raid array was not in degraded state at any stage
and no raid rebuild aver triggered.

> The next one is from Doug Ledford on 2004/09/18 and should only affect
> SMP.

Ok, as said, this is UP.
 
> My different raid machines run either reiserfs or xfs on soft raid5 on
> top of scsi and with kernel 2.4.27, so there's not much to compare...
> Perhaps someone on the list has a setup similar to yours and could test
> the kernel ?

I will try to contruct a similar setup on another machine.


thanks for your insights,

-- v -- 

v@iki.fi

