Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRCNPiH>; Wed, 14 Mar 2001 10:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRCNPh6>; Wed, 14 Mar 2001 10:37:58 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:60816 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131407AbRCNPhw>;
	Wed, 14 Mar 2001 10:37:52 -0500
Date: Wed, 14 Mar 2001 10:36:40 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
cc: <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <3AAF8A71.1C71D517@faceprint.com>
Message-ID: <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem:

drivers change their detection schemes; and changes in the kernel can
change the order in which devices are assigned names.

For example, the DAC960(?) drivers changed their order of
detecting controllers, and I did _not_ have fun, given that the machine in
question had about 40 disks to deal with, spread across two controllers.

This can create a lot of problems for people upgrading large, production
quality systems -- as, in the worst case, the system won't complete the
boot cycle; or in middle cases, the user/sysadmin is stuck rewriting X
amount of files and trying again; or in small cases, you find out that
your SMC and Intel ethernet cards are reversed, and have to go fix things
...

Possible solutions(?):

Solaris uses an /etc/path_to_inst file, to keep track of device ordering,
et al.

Maybe we should consider something similar, where a physical device to
logical device map is kept and used to keep things consistent on
kernel/driver changes; device addition/removal, and so forth ...

I am, of course, open to better solutions.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.


