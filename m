Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTH1RWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 13:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbTH1RWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 13:22:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30729
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261245AbTH1RWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 13:22:14 -0400
Date: Thu, 28 Aug 2003 10:22:14 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] extents support for EXT3
Message-ID: <20030828172214.GC21352@matchmail.com>
Mail-Followup-To: Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <m33cfm19ar.fsf@bzzz.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33cfm19ar.fsf@bzzz.home.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 12:22:04PM +0400, Alex Tomas wrote:
> 
> this is 2nd version of the patch. changes:
>   - error handling seems completed
>   - lots of cleanups and comments
>   - few minor bug fixed
> 
> this version of the patch tries to solve couple
> of corner cases:
>   - very long truncate
>   - rewrite 
> 
> it survived dbench, bonnie++ and fsx tests.
> 
> take a look at numbers I've just got, please.
> 
>                       before      after
> 5GB file, creation:   2m31.197s   2m21.933s
> 5GB file, read:       2m25.439s   2m24.833s
> 5GB file, rewrite:    2m48.434s   2m20.958s
> 5GB file, removal:    0m8.760s    0m0.858s

With extents, what are the worst/best cases for max file size on a 1k block
filesystem?  AFAICT, worst case is 16GB if it backs out to the second level
like we have now...
