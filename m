Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBGPs7>; Wed, 7 Feb 2001 10:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbRBGPsu>; Wed, 7 Feb 2001 10:48:50 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:27147 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129084AbRBGPsg>; Wed, 7 Feb 2001 10:48:36 -0500
Date: Wed, 07 Feb 2001 10:47:09 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>,
        "Vladimir V. Saveliev" <monstr@namesys.com>,
        "zag@zag.botik.ru" <zag@zag.botik.ru>,
        Alexander Zarochentcev <zam@namesys.com>,
        Yury Shevchuk <sizif@botik.ru>,
        Vladimir Demidov <vladimir_493451@mtu-net.ru>,
        Vitaly Fertman <vetal@namesys.com>,
        Edward Shushkin <edward@mail.infotel.ru>,
        Nikita Danilov <god@namesys.com>,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>,
        Alexander Lyamin <flx@msu.ru>,
        "Elena V. Gryaznova" <grev@uchcom.botik.ru>,
        "gawain@torque.com" <gawain@torque.com>,
        "ragnar@bigstorage.com" <ragnar@bigstorage.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <420500000.981560829@tiny>
In-Reply-To: <3A813A63.EBD1B768@namesys.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, how about we list the known bugs:

zeros in log files, apparently only between bytes 2048 and 4096 (not
reproduced yet).

preallocated block leak on crash (fix in testing)

hidden directory entry cleanup (still reproducing, very hard to hit).

knfsd (patches in testing).

oops in reiserfs_symlink, create_virtual_node (bug in redhat gcc 2.96,
fixed by downloading the update).

We've also had a few reports of other corruptions, most of which have been
traced to hardware problems.  There are two where I'm not sure of the cause
yet, but the method to trigger the bug was too simple to not be a hardware
problem.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
