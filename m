Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUDBWBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUDBWBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:01:00 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:4788 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261186AbUDBWA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:00:58 -0500
Message-ID: <406DE280.6050109@nortelnetworks.com>
Date: Fri, 02 Apr 2004 17:00:32 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jamie Lokier <jamie@shareable.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
References: <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz>
In-Reply-To: <20040402213933.GB246@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Actually, my solution has one weirdness...
> 
> 
>>a
> 
> copyfile a b
> rm a
> 
> ...now b has pointer to cowid with usage count of 1. Which is slightly
> ugly (and wastes one cowid entry), but should be harmless.

Could you not change it back to a normal inode when refcount becomes 1? 
  Or if you didn't want to do that always (say if you knew there would 
be more references being created soon) you could at least have some kind 
of cleanup tool that you could manually run on a filesystem to clean it up?

Chris
