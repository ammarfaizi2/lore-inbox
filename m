Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWIGXZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWIGXZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422722AbWIGXZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:25:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34964 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1422717AbWIGXZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:25:25 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4500AA02.5030507@s5r6.in-berlin.de>
Date: Fri, 08 Sep 2006 01:23:46 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Ben Collins <bcollins@ubuntu.com>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking
 detected
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>	 <20060905111306.80398394.akpm@osdl.org>	 <44FDCEAD.5070905@s5r6.in-berlin.de>	 <44FE751E.4030505@s5r6.in-berlin.de>	 <44FEFC68.90201@s5r6.in-berlin.de> <a44ae5cd0609071545p26b42432ife69bf7c63d41dd0@mail.gmail.com>
In-Reply-To: <a44ae5cd0609071545p26b42432ife69bf7c63d41dd0@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> I don't have time to do the bisection testing.  If there is a patch
> you'd like me to test against 2.6.18-rc5-mm1+all hotfixes, please let
> me know.  I apologize for not being able to narrow this down further
> for you.

Bisection is probably not necessary anymore. The issue seems to be much
older than -mm's changes to nodemgr. Please apply the patches
    ieee1394: nodemgr: fix rwsem recursion
    ieee1394: nodemgr: grab class.subsys.rwsem in nodemgr_resume_ne
on top of all of -mm. I posted them yesterday but will mail them again.
(linux1394-devel was kept in the dark by SpamCop.) Thanks a lot for your
help.
-- 
Stefan Richter
-=====-=-==- =--= -=---
http://arcgraph.de/sr/
