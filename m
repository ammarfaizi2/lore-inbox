Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWC0Ukt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWC0Ukt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWC0Ukt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:40:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751132AbWC0Uks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:40:48 -0500
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ams@gnu.org
Cc: cascardo@minaslivre.org, tytso@mit.edu, adilger@clusterfs.com,
       sho@bsd.tnes.nec.co.jp, cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Laurent.Vivier@bull.net,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060327200518.0413A44002@Psilocybe.Update.UU.SE>
References: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
	 <20060316183549.GK30801@schatzie.adilger.int>
	 <20060316212632.GA21004@thunk.org>
	 <20060316225913.GV30801@schatzie.adilger.int>
	 <20060318170729.GI21232@thunk.org>
	 <20060320063633.GC30801@schatzie.adilger.int>
	 <1142894283.21593.59.camel@orbit.scot.redhat.com>
	 <20060320234829.GJ6199@schatzie.adilger.int>
	 <1142960722.3443.24.camel@orbit.scot.redhat.com>
	 <20060321183822.GC11447@thunk.org>
	 <20060325145139.GA5606@cascardo.localdomain>
	 <1143489301.15697.9.camel@orbit.scot.redhat.com>
	 <20060327200518.0413A44002@Psilocybe.Update.UU.SE>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 15:40:32 -0500
Message-Id: <1143492032.15697.19.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-03-27 at 22:05 +0200, Alfred M. Szmidt wrote:
>    Now, a non-Hurd system is not going to have any use for the gnu.*
>    xattr semantics, as translator is a Hurd-specific concept.
> 
> gnu.* doesn't just concern itself with translators, it can also be
> gnu.author (or some such) which is a normal UID, which GNU/Linux can
> support without any problems.

OK, but would it have any active semantics on non-Hurd kernels?  How
would the behaviour of ext3 change in the presence of a gnu.author
attribute on a file?

It would certainly be possible to add a generic ext2/3 namespace handler
to allow those fields to be set on, say, Linux hosts; but that would
just be a matter of matching the gnu.* syscall xattr encoding to the
EXT2_XATTR_INDEX_GNU on-disk encoding; it wouldn't actually deal with
any semantic expectations surrounding the use of those fields.

--Stephen


