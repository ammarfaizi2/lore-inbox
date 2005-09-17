Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVIQMTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVIQMTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVIQMTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:19:09 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:8839 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751088AbVIQMTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:19:08 -0400
Date: Sat, 17 Sep 2005 14:18:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       Miklos Szeredi <miklos@szeredi.hu>, mike@waychison.com,
       bfields@fieldses.org, serue@us.ibm.com
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
Message-ID: <20050917121848.GA9106@wohnheim.fh-wedel.de>
References: <20050916182619.GA28428@RAM> <20050916142557.691b055e.akpm@osdl.org> <1126906755.4693.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1126906755.4693.25.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 September 2005 14:39:15 -0700, Ram Pai wrote:
> On Fri, 2005-09-16 at 14:25, Andrew Morton wrote:
> > linuxram@us.ibm.com (Ram) wrote:
> > >
> > > Lindentified fs/namespace.c
> > 
> > For something which is as already-close to CodingStyle as namespace.c it's
> > probably better to tidy it up by hand.  Lindent breaks almost as much stuff
> > as it fixes.
> 
> I thought Lindent was the gospel for codying style. Looks like its not.
> Will fix all of them.

It is an approximation.  In my personal experience, the "-l80"
parameter is doing a lot of harm.  It causes things like

	if (...)
		for (...)
			while (...)
				if (...)
					for (...)
						while (...)
							some_function(argument,
									very_long_argument,
									another_argument,
									0,
									1,
									NULL
									);

Code with many indentation levels is pressed hard against the 80
column limit.  Such code needs manual cleanup anyway and the 80 column
thing makes manual cleanup harder instead of easier.  Without that,
Lindent is a big initial improvement.

It is not the final word. :)

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
