Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262336AbSI3RXo>; Mon, 30 Sep 2002 13:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262339AbSI3RXo>; Mon, 30 Sep 2002 13:23:44 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:15017 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S262336AbSI3RXn>; Mon, 30 Sep 2002 13:23:43 -0400
Subject: Re: 2.5.39-bk2 compile failure with CONFIG_XFS_FS=y
From: Steven Cole <elenstev@mesatop.com>
To: Christoph Hellwig <hch@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020930194628.B15138@sgi.com>
References: <1033401002.32409.62.camel@spc9.esa.lanl.gov> 
	<20020930194628.B15138@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Sep 2002 11:01:16 -0600
Message-Id: <1033405276.32404.70.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 17:46, Christoph Hellwig wrote:
> On Mon, Sep 30, 2002 at 09:50:02AM -0600, Steven Cole wrote:
> > I got the following compile error building 2.5.39-bk2 with CONFIG_XFS_FS=y:
> 
> That's ingo smptimers work.  Quick hack below, but doesn't peform nicely
> on smp..
> 
[patch snipped]

Thanks.  That works for me for now.  Unfortunately, I only have an UP
box to do XFS testing presently, but I'll try to change that soon.  I'm
presently running dbench with increasing client counts on my xfs
partition with 3.5.39bk2.

Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda1     ext3    236M   68M  156M  31% /
/dev/hda9     ext3     20G  3.5G   17G  18% /home
/dev/hda11     jfs    3.9G  5.3M  3.9G   1% /share_j
/dev/hda10
          reiserfs    4.0G   37M  3.9G   1% /share_r
/dev/hda12     xfs    4.8G  250M  4.6G   6% /share_x
/dev/hda8     ext3    236M  5.2M  219M   3% /tmp
/dev/hda6     ext3    2.9G  1.5G  1.3G  55% /usr
/dev/hda7     ext3    479M   83M  372M  19% /var

Steven

