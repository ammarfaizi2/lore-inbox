Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288778AbSAELY6>; Sat, 5 Jan 2002 06:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288773AbSAELYr>; Sat, 5 Jan 2002 06:24:47 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:30960 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288769AbSAELYh>; Sat, 5 Jan 2002 06:24:37 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020105025042.A23360@baldur.yggdrasil.com> 
In-Reply-To: <20020105025042.A23360@baldur.yggdrasil.com> 
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.2-pre8/drivers/mtd compilation fixes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Jan 2002 11:24:23 +0000
Message-ID: <4082.1010229863@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


adam@yggdrasil.com said:
> 	The following patch updates linux-2.5.2-pre8/drivers/mtd to compile.
> This entails some kdev_t fixes and other updates for changes to the
> block device driver interface.

Looks sane - thanks. I see no harm in sending it to Linus. Could you run 
the blkmtd.c changes past spse@secret.org.uk first, though?

> 	In the case of one routine (ftl_reread_partitions), there was a goto
> to a nonexistant label (goto leave), so I think there may have been an
> incomplete patch applied to this subdirectory to begin with

Not in my tree - strange. Oh well, I'll deal with it when 2.5 stabilises 
and I stop ignoring it.

> (also, drivers/mtd/bootldr.c refers to a nonexistant "struct tag", but that
> file is apparently not currently compiled anyhow). 

Currently, it's only compiled in the iPAQ kernel tree, where it works - I'm
waiting for the iPAQ people and Russell to stop arguing about how it should
be done, so the result will work in the proper ARM tree (and hence Linus'
tree) too.

Btw, where did you get the address 'mtd@infradead.org' from? The list moved 
a while ago, and I was going to remove the forwarding some time soon.

--
dwmw2


