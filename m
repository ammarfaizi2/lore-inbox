Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbTH2Vjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTH2Vjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:39:42 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:41225
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262097AbTH2Vjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:39:39 -0400
Date: Fri, 29 Aug 2003 14:39:40 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] extents support for EXT3
Message-ID: <20030829213940.GC3846@matchmail.com>
Mail-Followup-To: Ed Sweetman <ed.sweetman@wmich.edu>,
	Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu> <m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu> <m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu> <m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu> <m3ad9snxo6.fsf@bzzz.home.net> <3F4FAFA2.4080202@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4FAFA2.4080202@wmich.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 03:55:14PM -0400, Ed Sweetman wrote:
> I would not recommend using the patch for system directories only 
> because it leaves you with no way to rescue the system and does very 
> little in the way of performance for those directories. Ext3 is 
> backwards compatible with ext2, this patch seemingly breaks that. 
> Because of that it doesn't seem to be ext3 anymore, rather a one way 
> compatibility with ext3 with a purely large media bias.

Do you get any slowdown with the extents on small files though?

The plan is to add extent reading code to the three other stable trees so
that at the very least you could have read-only access to the extent based
ext2/3.

Remember, if the implementation of journaling hadn't have been so extensive,
we wouldn't have an ext3, but ext2 with journaling (and called ext2).

So what this will be is ext2 format with extents, and with (ext3) or without
journaling (ext2).

And this is planned for 2.7, so if anything goes into 2.6, it'll be
read-only support of extents.
