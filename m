Return-Path: <linux-kernel-owner+w=401wt.eu-S1751460AbXARASo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXARASo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 19:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXARASo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 19:18:44 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:23470 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbXARASn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 19:18:43 -0500
Date: Thu, 18 Jan 2007 00:18:38 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Turbo Fredriksson <turbo@bayour.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird harddisk behaviour
Message-ID: <20070118001838.GA340@deepthought>
References: <87bqkzp0et.fsf@pumba.bayour.com> <20070116141959.GC476@deepthought> <87y7o2hsmm.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y7o2hsmm.fsf@pumba.bayour.com>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 11:09:21AM +0100, Turbo Fredriksson wrote:
> Quoting Ken Moffat <zarniwhoop@ntlworld.com>:
> 
> >  Certainly, fdisk from util-linux doesn't know about mac disks, and
> > I thought the same was true for cfdisk and sfdisk.  Many years ago
> > there was mac-fdisk, I think also known as pdisk, but nowadays the
> > common tool for partitioning mac disks is probably parted.
> 
> Yes. See now that 'fdisk' is a softlink to 'mac-fdisk'...
> 

 Sorry for not replying earlier, cutting the Cc: list on lkml is not
always conducive to quick replies.

 So, you were using a valid tool, but what you put in your original
mail shows garbage - something like apple_partition_ma[mamama...
followed later by some garbage which could admittedly have been UTF-8
getting trashed in the mail.  I'm on my ibook at the moment, which
has an old debian mac-fdisk on another partition.  If I chroot to
that and look at the disk I see things like

/dev/hda
        #                    type name                 length   base     ( size )  system
/dev/hda1     Apple_partition_map Apple                    63 @ 1        ( 31.5k)  Partition map
/dev/hda2         Apple_Bootstrap untitled               1954 @ 64       (977.0k)  NewWorld bootblock

 and so forth.  Notice that everything there is in legible ascii and
can be read with sensible values.  If what you actually see is
similar, then it's just a problem in the mail.  But if it isn't,
somehow the data on the disk (or the data being read from it) is
corrupt.

ĸen
-- 
das eine Mal als Tragödie, das andere Mal als Farce
