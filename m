Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263697AbUECOKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUECOKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 10:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUECOKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 10:10:22 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:30667 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263697AbUECOKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 10:10:19 -0400
Date: Mon, 3 May 2004 16:10:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@stanford.edu,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>
Subject: Re: [Ext2-devel] [CHECKER] warnings in fs/ext3/namei.c (2.4.19) where disk read errors get ignored, causing non-empty dir to be deleted
Message-ID: <20040503141001.GA23656@wohnheim.fh-wedel.de>
References: <Pine.GSO.4.44.0404262339360.7250-100000@elaine24.Stanford.EDU> <20040427074455.GD30529@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040427074455.GD30529@schnapps.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 April 2004 01:44:55 -0600, Andreas Dilger wrote:
> 
> Again a conscious decision.  If a name is potentially inaccessible because
> of an IO error it is better to allow the creation of a potentially duplicate
> name than refuse creation of any new entries in the directory.  It's a matter
> of allowing the filesystem to be used as well as possible in the face of
> failures vs. just giving up and refusing to do anything.

Do you mind if I doubt the sanity of whoever made that decision?  When
my hard drive fails, I don't care about writing to the fs too much
anymore, I want to *notice* the failure early and to *read* as much as
possible, then put the drive on a pile for test hardware.

But then again, that's just me.

Jörn

-- 
A surrounded army must be given a way out.
-- Sun Tzu
