Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUDBQy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUDBQy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:54:56 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:59322 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264098AbUDBQyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:54:55 -0500
Date: Fri, 2 Apr 2004 18:54:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040402165440.GB24861@wohnheim.fh-wedel.de>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040329231635.GA374@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 March 2004 01:16:35 +0200, Pavel Machek wrote:
> 
> I think they *should* have separate permissions.

That makes the count 2:2.  I'll continue to follow the simple solution
for some time, but wouldn't like to have it included for now (or ever?)

> Also it should be possible to have file with 2 hardlinks cowlinked
> somewhere, and possibly make more hardlinks of that one... Having
> pointer to another inode in place where direct block pointers normally
> are should be enough (thinking ext2 here).

All right, you are proposing hell.  I've tried to think through all
possibilities and was too scared to continue.  So limitation is that
cowlinks and hardlinks are mutually exclusive, which eliminated all
problems.

If you really want cowlinks and hardlinks to be intermixed freely, I'd
happily agree with you as soon as you can define the behaviour for all
possible cases in a simple document and none of them make me scared
again.  Show me that it is possible and makes sense.

Jörn

-- 
A quarrel is quickly settled when deserted by one party; there is
no battle unless there be two.
-- Seneca
