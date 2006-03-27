Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWC0UgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWC0UgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWC0UgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:36:21 -0500
Received: from colibri.its.uu.se ([130.238.4.154]:63925 "EHLO
	colibri.its.uu.se") by vger.kernel.org with ESMTP id S1750879AbWC0UgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:36:20 -0500
From: "Alfred M. Szmidt" <ams@gnu.org>
To: Andreas Dilger <adilger@clusterfs.com>
CC: cascardo@minaslivre.org, tytso@mit.edu, sct@redhat.com,
       sho@bsd.tnes.nec.co.jp, cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Laurent.Vivier@bull.net
In-reply-to: <20060326162744.GA13185@schatzie.adilger.int> (message from
	Andreas Dilger on Sun, 26 Mar 2006 09:27:44 -0700)
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Reply-to: ams@gnu.org
References: <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com> <20060321183822.GC11447@thunk.org> <20060325145139.GA5606@cascardo.localdomain> <20060326162744.GA13185@schatzie.adilger.int>
Message-Id: <20060327203607.7029D44004@Psilocybe.Update.UU.SE>
Date: Mon, 27 Mar 2006 22:36:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   So, if fs creator is Linux then HURD doesn't try to use those
   fields?

As I recall it (don't have access to the source code here), the
file-system translator will return EOPNOTSUPP if you try and set a
passive translator on a non-Hurd owned file-system.  Passive
translators are the only kind of translators which write any kind of
data back to the acutal file-system.

For the case of st_author/i_author, when the file is created on a
non-Hurd owned file-system, it will simply return whatever
i_uid/st_uid is.

   Not that we will be in a rush to use these fields, but it would be
   good to know what i_mode_high is used for in case it ever becomes
   relevant for Linux we would want to keep it the same meaning as
   HURD.

Once again, as I recall it (a bit better this time), i_mode_high is
used for the actual bits that define if there is a translator (and
what kind) on a node or not.

Cheers.
