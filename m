Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWC0T7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWC0T7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWC0T7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:59:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6021 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751041AbWC0T7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:59:33 -0500
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: cascardo@minaslivre.org, "Theodore Ts'o" <tytso@mit.edu>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060326162744.GA13185@schatzie.adilger.int>
References: <20060316183549.GK30801@schatzie.adilger.int>
	 <20060316212632.GA21004@thunk.org>
	 <20060316225913.GV30801@schatzie.adilger.int>
	 <20060318170729.GI21232@thunk.org>
	 <20060320063633.GC30801@schatzie.adilger.int>
	 <1142894283.21593.59.camel@orbit.scot.redhat.com>
	 <20060320234829.GJ6199@schatzie.adilger.int>
	 <1142960722.3443.24.camel@orbit.scot.redhat.com>
	 <20060321183822.GC11447@thunk.org>
	 <20060325145139.GA5606@cascardo.localdomain>
	 <20060326162744.GA13185@schatzie.adilger.int>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 14:59:14 -0500
Message-Id: <1143489555.15697.12.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-03-26 at 09:27 -0700, Andreas Dilger wrote:

> I'm not sure what is required for supporting such EAs?  I don't think
> any kernel would remove existing EAs, even if it doesn't understand
> them.

Right --- reservation in fs/ext[23]/xattr.h is sufficient, I think, as
all we need is to make sure that the gnu.* on-disk namespace is reserved
against reuse by any new namespaces in the future.

--Stephen


