Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264435AbRFKMpF>; Mon, 11 Jun 2001 08:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264464AbRFKMoz>; Mon, 11 Jun 2001 08:44:55 -0400
Received: from t2.redhat.com ([199.183.24.243]:11761 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264435AbRFKMok>; Mon, 11 Jun 2001 08:44:40 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3B24AF66.3010602@AnteFacto.com> 
In-Reply-To: <3B24AF66.3010602@AnteFacto.com>  <20010525005253.A16005@bug.ucw.cz> 
To: Padraig Brady <Padraig@AnteFacto.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
        jffs-dev@axis.com
Subject: Re: jffs on non-MTD device? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Jun 2001 13:41:08 +0100
Message-ID: <3437.992263268@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Padraig@AnteFacto.com said:
> Some (most?) CF disks have hareware wareleveling. I use ext2 with
> e2compr patch.

There are some who want a journalling filesystem on their CF device. 
Did anyone do e3compr yet? :)

Personally, I wouldn't bother with it - these things have a form of
pseudo-filesystem, probably similar to FTL or NFTL, implemented internally
to emulate a block device, and it's been reported that they don't do that
particularly well - they break down and lose data if you put them through
the kind of repeated power cycle tests that JFFS and JFFS2 have been
subjected to. A journalling filesystem on an unreliable medium is sort of 
pointless.

Far better to use a real flash device. But maybe I'm biased :)

--
dwmw2


