Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281857AbRKRGsN>; Sun, 18 Nov 2001 01:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281858AbRKRGsC>; Sun, 18 Nov 2001 01:48:02 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62049 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281857AbRKRGru>; Sun, 18 Nov 2001 01:47:50 -0500
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Michael Peddemors <michael@wizard.ca>, linux-kernel@vger.kernel.org
Subject: Re: Current Max Swap size? Performance issues
In-Reply-To: <1005948151.10803.18.camel@mistress>
	<20011116163346.L1308@lynx.no>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2001 23:28:50 -0700
In-Reply-To: <20011116163346.L1308@lynx.no>
Message-ID: <m1itc88ue5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolabs.com> writes:

> On Nov 16, 2001  14:02 -0800, Michael Peddemors wrote:
> > With all of the latest VM, again the question is asked...  Best way to
> > set up swap now..
> > 
> > For 2 GIG memory...
> > Channel 0 is RAID 1 SCSI
> > Channel 2 is RAID 1+0 SCSI
> > Hardware Raid
> > 
> > Shoudl it be?
> > 
> > 2 GIG swap partition (Is this still the limit?)
> 
> Yes, still the limit.  It turns out that this is not an on-disk format
> limit, but rather an in-memory structure limit, in case you cared.  For
> non-x86 platforms, there is a different limit.

Where?  The limit should be about 64GB or so on x86.  If it isn't it should
be just a couple of lines to change it.  Or is the limit the vmalloc
of the swap_map?

I skimmed the code a while ago but I haven't had the time to patch mkswap
and actually try it with something larger.


Eric
