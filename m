Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVGYVB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVGYVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVGYVB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:01:59 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:20313 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261442AbVGYVBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:01:34 -0400
Date: Mon, 25 Jul 2005 23:01:33 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andreas Baer <lnx1@gmx.net>, Willy Tarreau <willy@w.ods.org>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
Message-ID: <20050725210132.GC20811@harddisk-recovery.com>
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local> <42E542D5.3080905@gmx.net> <20050725200330.GA20811@harddisk-recovery.nl> <9a874849050725133853953bd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a874849050725133853953bd4@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 10:38:25PM +0200, Jesper Juhl wrote:
> It's even more complex than that as far as I know, you also have the
> issue of seek times - tracks near the middle of the platter will be
> nearer the head more often (on average) then tracks at the edge.
> 
> For people who like visuals, IBM has a nice little picture in their
> AIX performance tuning guide :
> http://publib.boulder.ibm.com/infocenter/pseries/index.jsp?topic=/com.ibm.aix.doc/aixbman/prftungd/diskperf2.htm

Quote from that document:

 "Data is more dense as it moves toward the center, resulting in less
  physical movement of the head. This results in faster overall
  throughput"

This is not true. The whole idea of different recording zones with
different sectors/track is to keep the overall data density (in
bits/square mm) more or less constant.

I'd say it's even the other way around from what IBM pictures: there
are more sectors/track in outer zones, so that means there is simply
more data in the outer zones. If you want less physical movement of the
head, you should make sure the data is in the zone(s) with the largest
number of sectors/track.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
