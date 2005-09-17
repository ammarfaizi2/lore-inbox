Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVIQMfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVIQMfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVIQMfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:35:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6887 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751097AbVIQMfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:35:07 -0400
Date: Sat, 17 Sep 2005 13:34:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Ram Pai <linuxram@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>, mike@waychison.com,
       bfields@fieldses.org, serue@us.ibm.com
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
Message-ID: <20050917123457.GJ19626@ftp.linux.org.uk>
References: <20050916182619.GA28428@RAM> <20050916142557.691b055e.akpm@osdl.org> <1126906755.4693.25.camel@localhost> <20050917121848.GA9106@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917121848.GA9106@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 02:18:48PM +0200, J?rn Engel wrote:
> On Fri, 16 September 2005 14:39:15 -0700, Ram Pai wrote:
> > On Fri, 2005-09-16 at 14:25, Andrew Morton wrote:
> > > linuxram@us.ibm.com (Ram) wrote:
> > > >
> > > > Lindentified fs/namespace.c
> > > 
> > > For something which is as already-close to CodingStyle as namespace.c it's
> > > probably better to tidy it up by hand.  Lindent breaks almost as much stuff
> > > as it fixes.
> > 
> > I thought Lindent was the gospel for codying style. Looks like its not.
> > Will fix all of them.
> 
> It is an approximation.  In my personal experience, the "-l80"
> parameter is doing a lot of harm.  It causes things like
> 
> 	if (...)
> 		for (...)
> 			while (...)
> 				if (...)
> 					for (...)
> 						while (...)
> 							some_function(argument,
> 									very_long_argument,
> 									another_argument,
> 									0,
> 									1,
> 									NULL
> 									);
> 

... show up as unreadable crap they are.  I fail to see a problem...
Fix them and run Lindent again, that's it.

Lindent behaviour wrt labels is far more annoying, ditto for the mess it
often makes out of prototypes (demonstrated in the patch in question).

IME the best way to use Lindent is to do vi -c 's/[[:space:]]*$//|x' foo.c
first, then run Lindent, then walk through prototypes and fix them,
diff with pre-Lindent version and see if it looks sane...
