Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWH0RPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWH0RPW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWH0RPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:15:22 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:40916 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932188AbWH0RPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:15:21 -0400
Date: Sun, 27 Aug 2006 19:15:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Al Boldi <a1426z@gawab.com>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Eric Van Hensbergen <ericvh@gmail.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] VFS: FS CoW using redirection
Message-ID: <20060827171510.GA3502@wohnheim.fh-wedel.de>
References: <200607082041.54489.a1426z@gawab.com> <20060823172402.GC15851@wohnheim.fh-wedel.de> <20060823180552.GC28873@filer.fsl.cs.sunysb.edu> <200608262205.21397.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200608262205.21397.a1426z@gawab.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 August 2006 22:05:21 +0300, Al Boldi wrote:
> 
> So what was the rejecting theme?

I don't believe there was one.  Jan simply didn't push much, so noone
was forced to resist him.  And noone else needed union mount enough to
push Jan.

> > Or you can give Unionfs a try: http://www.unionfs.org
> 
> UnionFS is great, but it incurs additional overhead, as it lives below the 
> real VFS.  What could be really great, is to move some basic functionality 
> abstractions from UnionFS into VFS proper.

Welcome to Jan's work. :)

If you want to make this vision happen, one of the missing pieces is a
method for copyup, an in-kernel copying routine.  Unionfs needs is
just the same as Jan's patches do and in the past Linus didn't like my
approach of using sendfile for it.  You could take a stab at the
splice code and see how that can be used for copyup.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface.
-- Doug MacIlroy
