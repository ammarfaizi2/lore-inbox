Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTDXPK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTDXPK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:10:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:64941 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263465AbTDXPK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:10:26 -0400
Message-ID: <3EA80134.5080408@gmx.net>
Date: Thu, 24 Apr 2003 17:22:28 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com,
       ncunningham@clear.net.nz, gigerstyle@gmx.ch, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz> <20030423170759.2b4e6294.akpm@digeo.com> <20030424002544.GC2925@elf.ucw.cz>
In-Reply-To: <20030424002544.GC2925@elf.ucw.cz>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>
>>>If you really want to "solve" it reliably, you can always
>>>
>>>swapon /dev/hdfoo666
>>>
>>
>>Seems that using a swapfile instead of a swapdev would fix that neatly.
>>
>>But iirc, suspend doesn't work with swapfiles.  Is that correct?  If so,
>>what has to be done to get it working?
>
>
> Swapfile does not work, because even readonly mount wants to replay
> logs, and that'd be disk corruption.
>
> It could be doable with modifications to the filesystems, but it would
> be hard (and I do not think it is worth it).
> 								Pavel
>
Any non-journaling filesystem should work out fine. And if you don't
trust ext2, you can still use xiafs once I've finished porting it to 2.5

Carl-Daniel
-- 
http://www.hailfinger.org/

