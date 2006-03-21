Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWCUXFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWCUXFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWCUXFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:05:19 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:40713 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751811AbWCUXFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:05:18 -0500
Date: Wed, 22 Mar 2006 00:05:16 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
       cascardo@minaslivre.org
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060321230516.GB45303@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
	cascardo@minaslivre.org
References: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com> <20060321183822.GC11447@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321183822.GC11447@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 01:38:22PM -0500, Theodore Ts'o wrote:
> Hurd is definitely using the translator field, and I only recently
> discovered they are using it to point at a disk block where the name
> of the translator program (I'm not 100% sure, but I think it's a
> generic, out-of-band, #! sort of functionality).

Translators on directories are a combo of automount+userland
filesystem, with the addition on having them saved in the mounted-on
filesystem.  Rather nice actually.  Replacing /etc/fstab with
local-to-the-mountpoint information has some charm.  I'm not sure if
translator-on-files actually exist.

Note that in hurd all filesystems are userland.  Whether it is a good
thing is left as an exercise to the benchmarker and the deadlock
chaser.

  OG.

