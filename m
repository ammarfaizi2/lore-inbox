Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263974AbRFHMLu>; Fri, 8 Jun 2001 08:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263978AbRFHMLk>; Fri, 8 Jun 2001 08:11:40 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:33269 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S263974AbRFHMLi>; Fri, 8 Jun 2001 08:11:38 -0400
Message-Id: <l0313032ab74670af4963@[192.168.239.105]>
In-Reply-To: <3B20B5B1.D659489F@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 8 Jun 2001 13:10:53 +0100
To: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: VM: Buffer vs. Cache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> just being curious. Since 2.4.4, I am watching my systems memory
>behaviour a bit:-) Just recently I realized the following: in the
>evening I leave my 128MB system at about 20 MB, 2 MB Buffered and 100 MB
>Cached (plus som 40 MB unneccesary swap :-)). When I come back in the
>morning, Used is still at 20 MB (a bit down maybe) but Buffered is 50 MB
>and Cached is 55 MB. For a few minutes the system is definitely more
>sluggish than in the evening. Something I can excuse before my first cup
>of coffe anyway...
>
> So, what actually is the difference between Buffered and Cached.
>Apparently quite a lot of the pages that are Cached in the evening are
>Buffered 9 houres later.

Think about what happens in the meantime.  Most distros install maintenance
scripts which run late at night (usually at midnight and/or 4am), which
perform heavy disk activity as they update databases and scan for
file-permissions security holes.  Heavy disk activity usually means an
increase in buffer utilisation.  Since most files are only "touched" once,
the cache is shrunk as it aren't being used very much.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


