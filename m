Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264194AbUEHWMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbUEHWMy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264195AbUEHWKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:10:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28338 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264194AbUEHWKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:10:18 -0400
Date: Sun, 9 May 2004 00:10:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040508221017.GA29255@atrey.karlin.mff.cuni.cz>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> That is probably unfixable now, but you can avoid making similar
> error. Provide is_cowlinked(fd1,fd2) syscall. Pity you will
> have to use different inode numbers for cowlinks (due to tar/cp),
> and this won't fly:

is_cowlinked does not fly, either. For n files, you have to do O(n^2)
calls to find those that are linked.

You want get_cowlinked_id which can return -1 "I do not know".

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
