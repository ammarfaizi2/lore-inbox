Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314004AbSDKGnD>; Thu, 11 Apr 2002 02:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314006AbSDKGnC>; Thu, 11 Apr 2002 02:43:02 -0400
Received: from rj.SGI.COM ([204.94.215.100]:62374 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S314004AbSDKGnB>;
	Thu, 11 Apr 2002 02:43:01 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion 
In-Reply-To: Your message of "Wed, 10 Apr 2002 19:41:11 MST."
             <20020411024111.GL23513@matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Apr 2002 16:42:20 +1000
Message-ID: <3004.1018507340@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002 19:41:11 -0700, 
Mike Fedyk <mfedyk@matchmail.com> wrote:
>Then you'd just need to make sure that if there are any block modules linked
>into the kernel that raid is also linked into the kernle instead of a module.
>
>Is there some reason why this wouldn't work (except for CML1
>complications...)?
>
>Kieth, will kbuild2.5 affect this in any way?  Or is this entirely a CML2
>thing? 

AFAICT it is pure config.  kbuild 2.5 does not care how .config is
built, it just requires a clean .config.  I want a clean seperation
between configuring and building the kernel.  In particular, Makefile
rules should not try to adjust for broken config entries, this is a
config only problem.

