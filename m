Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTEHPcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTEHPcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:32:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:647
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261753AbTEHPcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:32:53 -0400
Subject: Re: [PATCH] 2.5 ide 48-bit usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0305081532170.12362-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0305081532170.12362-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052405215.10038.44.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 15:46:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 14:35, Bartlomiej Zolnierkiewicz wrote:
> Yep, you are right, hwif->addressing logic is reversed, what a mess.

No the problem is you keep treating it as a binary value. Addressing is
a mode. Right now 0 is LBA28/CHS and 1 is LBA48. SATA next generation
stuff extends this even further so will I imagine be addressing=2

