Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTIVNuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTIVNuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:50:24 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:13443 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263152AbTIVNuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:50:19 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Subject: Re: 2.6.0-test5-mm4
Date: Mon, 22 Sep 2003 14:49:37 +0100
User-Agent: KMail/1.5.9
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <200309221317.42273.alistair@devzero.co.uk> <20030922143605.GA9961@gemtek.lt>
In-Reply-To: <20030922143605.GA9961@gemtek.lt>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309221449.37677.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 15:36, Zilvinas Valinskas wrote:
[snip]
> >
> > VFS: Cannot open root device "302" or hda2.
> > Please append correct "root=" boot option.
> > Kernel Panic: VFS: Unable to mount root fs on hda2.
>
> Do you use devfsd ?
>

No. As I said, I mount /dev with mount -t devfs devfs /dev in a sysinit 
bootscript. Whether it's in the kernel or not shouldn't make any difference. 
Maybe I just need to reissue LILO after booting the 32bit dev_t kernel?

> I had to specify root like this :
> root=/dev/ide/host0/bus0/target0/lun0/part5  then it worked just fine.
>

I'll try that, thanks. But I have this in lilo.conf:

boot=/dev/discs/disc0/disc
root=/dev/discs/disc0/part2

/dev/discs is indeed a symlink, but it should be resolved when LILO is 
installed, i.e., prior to the reboot. Why has this behaviour changed?

Cheers,
Alistair.
