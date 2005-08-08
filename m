Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVHHO46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVHHO46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVHHO46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:56:58 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.4.204]:38859 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750900AbVHHO45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:56:57 -0400
Date: Mon, 08 Aug 2005 10:56:56 -0400
From: Mathieu Chouquet-Stringer <ml2news@optonline.net>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: Re: cifs kernel module and MS DFS shares [2.6.12-1.1411_FC4]
In-reply-to: <200508081526.55555@moveAlongNothingToSeeHere>
To: thomas.chiverton@bluefinger.com (Thomas Chiverton)
Cc: linux-kernel@vger.kernel.org
Message-id: <m3pssobhon.fsf@mcs.bigip.mine.nu>
Organization: Uh?
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
References: <200508081526.55555@moveAlongNothingToSeeHere>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thomas.chiverton@bluefinger.com (Thomas Chiverton) writes:
> [root@charles-compaq gbb_domain]#  mount.cifs //exchsvr/dfs /mnt/dfs/ -o 
> user=tchiverton,domain=BLUEFINGER
> Password:
> [root@charles-compaq gbb_domain]#  ls /mnt/dfs/
> Applications  Consultants  Engineering  Management            Version
> Common        Directors    Finance      Software Development  WinTA Data
> [root@charles-compaq gbb_domain]# ls /mnt/dfs/Consultants/
> Applications  Consultants  Engineering  Management            Version
> Common        Directors    Finance      Software Development  WinTA Data
> [root@charles-compaq gbb_domain]#      

I've got the same issue but if I go down 2 or 3 levels, it works (ie
continue to go down the same directory until you see a valid content). Even
better, I can cd into non existing directories and it "works" (as in I
still see the content of the mountpoint).
So using your example, to see the real content of Consultants, I would have
to do this:
cd /mnt/dfs/Consultants/Consultants/Consultants
or this
cd /mnt/dfs/what/ev/Consultants

I haven't looked at the source yet so I'm not sure what's going on there...
-- 
Mathieu Chouquet-Stringer
    "Le disparu, si l'on vénère sa mémoire, est plus présent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exupéry, Citadelle --
