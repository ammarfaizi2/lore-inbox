Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUCMWOh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbUCMWOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:14:36 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:46792 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263205AbUCMWOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:14:32 -0500
Date: Sat, 13 Mar 2004 23:14:33 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sytse Wielinga <s.b.wielinga@student.utwente.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040313221433.GA6813@wohnheim.fh-wedel.de>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de> <200403121849.03505.s.b.wielinga@student.utwente.nl> <20040312182912.GB7087@wohnheim.fh-wedel.de> <20040313134330.GC3352@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040313134330.GC3352@openzaurus.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 March 2004 14:43:30 +0100, Pavel Machek wrote:
> 
> I do not know your current design, but...
> 
> In ideal world there would be no COW links. System would
> magically detect that you are doing cp -a, and would link
> at individual block level.
> 
> Well, that would be probably too fs-specific. But introducing copyfile()
> syscall, which would just link the inodes if underlying fs
> supported it might be good start. On first
> write into one
> of linked files copy
> would be done...

On second thought, I already have introduced copyfile() in a way - the
link() syscall is hijacked for exactly that purpose and my ugly flag
multiplexes between them.  Yeah, ugly as hell, but enough to get
started and test things.

Once the data structures are clear and at least one filesystem can
deal with it, things should be stable enough to think about the user
interface more seriously.

Jörn

-- 
The only real mistake is the one from which we learn nothing.
-- John Powell
