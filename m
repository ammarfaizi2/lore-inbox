Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUAQBGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 20:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUAQBGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 20:06:23 -0500
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:34031 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S265922AbUAQBGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 20:06:21 -0500
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: scheduler coolness
Date: Fri, 16 Jan 2004 20:06:18 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401162006.18040.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just comparing notes:

i run 2.4.22 with OpenMOSIX and Win4Lin patches, as well as the 2 latest 
security patches. For graphics, I use only gdm on the headless server (a P3 
667 w/512MB) and a diskless NFS root X terminal thru XDMCP on the clients 
(anything from celery 433 to P133). After worrying that my apps would knock 
down the activity of the other users, I thought to nice all my processes and 
let the masses have whatever Mozilla wants (since that's all they'll be 
running ;) . The other terminals aren't even setup yet, but I was getting 
severe sluggishness that made me thirst for GHz.

So after I hung up my terminal many times and watched it lock during heavy 
user load, being the only user(!), I decided to go ahead and nice everything 
under gdm. I edited /etc/X11/gdm/Xsession and put a 'nice' in every 'exec 
somewindowmanager' and now everything is faster. I mean, the local X is far 
more responsive, windows draw sooner, and apps don't momentarily hang the 
display... I'm assuming this is due to gdm now having the highest priority in 
userspace aside from the various daemons, thus less network latency and so 
on. so all is grand.

any thoughts/comments? 
(_besides_ that i'm mad for mixing OpenMOSIX and Win4Lin 8^)

-- 
Rob Couto
rpc@cafe4111.org
Rules for computing success:
1) Attitude is no substitute for competence.
2) Ease of use is no substitute for power.
3) Safety matters; use a static-free hammer.
--
