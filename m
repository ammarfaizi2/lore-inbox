Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLCOAZ>; Sun, 3 Dec 2000 09:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbQLCOAO>; Sun, 3 Dec 2000 09:00:14 -0500
Received: from www1.ExperTeam.de ([195.138.53.252]:6002 "EHLO
	www1.ExperTeam.de") by vger.kernel.org with ESMTP
	id <S129455AbQLCOAB>; Sun, 3 Dec 2000 09:00:01 -0500
Message-Id: <200012031330.OAA04450@www1.ExperTeam.de>
X-Mailer: exmh version 2.2 06/23/2000 (debian 2.2-1) with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
X-Face: "7u#"=sUEnmXhasPDW#QwNqMOaW5JQ2,rqy\Yt"a1yk9LI640Mv9g!TLQpp/tatO@T`=S:S
 xuqEDD30%F#fw>|!oX?g24"P/fr%)/]LhB~9++.hNy]}X/@q(XPGn:~p[q:n_[.B-SE;?J,%gHIq;N
 bl+of~~UF8/A9Jat?P!=Y%Q18tk
Organization: ExperTeam AG
Subject: Problems with CDROMVOLCTRL
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Dec 2000 14:25:02 +0100
From: Roderich Schupp <rsch@ExperTeam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
CDROMVOLCTRL does not work with my configuration in test11.
The ioctl always returns an error and volume stays the same
(seen with xmcd and gtcd). I tried the patch at

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/cd-1.bz2

This changed the error code from some bogus large positive number
to -EOPNOTSUPP :) However, volume control works fine in 2.2.17,
so the hardware shouldn't be the culprit.
The cdrom drive in question is an old TEAC CD-56S on an 
Adaptec AHA-2940 (narrow) controller.

Cheers, Roderich
-- 
There is something to be learned from a rainstorm. When meeting with 
a sudden shower, you try not to get wet and run quickly along the road.
But doing such things as passing under the eaves of houses, you still
get wet. When you are resolved from the beginning, you will not be
perplexed, though you still get the same soaking. 

         -- Hagakure - The Book of the Samurai

Roderich Schupp 		mailto:rsch@ExperTeam.de
ExperTeam GmbH			http://www.experteam.de/
Munich, Germany

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
