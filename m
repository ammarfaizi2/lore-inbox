Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUFISsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUFISsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUFISsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:48:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:51433 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265900AbUFISsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:48:23 -0400
Subject: Re: [STACK] >3k call path in reiserfs
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <40C75273.7020508@namesys.com>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>
	 <1086784264.10973.236.camel@watt.suse.com>
	 <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com>
	 <20040609172843.GB2950@wohnheim.fh-wedel.de> <40C75273.7020508@namesys.com>
Content-Type: text/plain
Message-Id: <1086806933.10973.299.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 14:48:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 14:09, Hans Reiser wrote:

> Unless it is really necessary, or a small code change, I would prefer to 
> spend our cycles worrying about this in reiser4, because code changes in 
> V3 are to be avoided if possible.
> 
> I am open to arguments that it is really necessary.

It's pretty important, especially when you toss NFS into the call path
the stack usage can go higher.  The switch to kmalloc will be relatively
small and by now we're good at testing for schedule bugs.

-chris


