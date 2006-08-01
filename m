Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWHASg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWHASg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWHASgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:36:55 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:59552 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751776AbWHASgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:36:55 -0400
Message-ID: <44CF3CBF.8050600@namesys.com>
Date: Tue, 01 Aug 2006 05:36:31 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vitaly Fertman <vitaly@namesys.com>
CC: David Masover <ninja@slaphack.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de>	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>	 <1154446189.15540.43.camel@localhost.localdomain>	 <44CF84F0.8080303@slaphack.com> <1154452770.15540.65.camel@localhost.localdomain>
In-Reply-To: <1154452770.15540.65.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, I have seen only anecdotal evidence against reiserfsck, and I have
seen formal tests from Vitaly  (which it seems a user has replicated)
where our fsck did better than ext3s.  Note that these tests are of the
latest fsck from us: I am sure everyone understands that it takes time
for an fsck to mature, and that our early fsck's were poor.  I will also
say the V4's fsck is more robust than V3's because we made disk format
changes specifically to help fsck.

Now I am not dismissing your anecdotes as I will never dismiss data I
have not seen, and it sounds like you have seen more data than most
people, but I must dismiss your explanation of them. 

Being able to throw away all of the tree but the leaves and twigs with
extent pointers and rebuild all of it makes V4 very robust, more so than
ext3.  This business of inodes not moving, I don't see what the
advantage is, we can lose the directory entry and rebuild just as well
as ext3, probably better because we can at least figure out what
directory it was in.

Vitaly can say all of this more expertly than I....

Hans
