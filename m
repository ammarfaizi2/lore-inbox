Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264822AbUEJP5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264822AbUEJP5C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbUEJP5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:57:01 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:9108 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264822AbUEJP4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:56:51 -0400
Date: Mon, 10 May 2004 17:56:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040510155624.GC16182@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua> <20040508221017.GA29255@atrey.karlin.mff.cuni.cz> <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua> <20040509215351.GA15307@atrey.karlin.mff.cuni.cz> <20040510154450.GA16182@wohnheim.fh-wedel.de> <20040510155127.GD27008@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040510155127.GD27008@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 17:51:27 +0200, Pavel Machek wrote:
> > 
> > What about ino?  I currently return 1, so diff remains fast without
> > any changes.  If someone really needs the difference between inode 2
> > and 3, I would introduce a cstat() system call similar to lstat(),
> > which would return ino=2.
> 
> I think you need to return 2, otherwise inode numbers change when
> cowling is broken.... and that would be bad.

Makes sense.  Damn, now I gotta touch diff as well. :(

> Aha.. That is another neccessary property for get_cow_inode():
> cow_inode can change, any time, unlike normal inode.

Correct.  Still, I prefer cstat(), even though almost all information
is identical to stat.  But the device might change as well, one day.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
