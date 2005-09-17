Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVIQNdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVIQNdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 09:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVIQNdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 09:33:13 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:18315 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751105AbVIQNdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 09:33:12 -0400
Date: Sat, 17 Sep 2005 15:33:00 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Ram Pai <linuxram@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>, mike@waychison.com,
       bfields@fieldses.org, serue@us.ibm.com
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
Message-ID: <20050917133300.GA12369@wohnheim.fh-wedel.de>
References: <20050916182619.GA28428@RAM> <20050916142557.691b055e.akpm@osdl.org> <1126906755.4693.25.camel@localhost> <20050917121848.GA9106@wohnheim.fh-wedel.de> <20050917123457.GJ19626@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050917123457.GJ19626@ftp.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 September 2005 13:34:57 +0100, Al Viro wrote:
> On Sat, Sep 17, 2005 at 02:18:48PM +0200, J?rn Engel wrote:
> > 
> > It is an approximation.  In my personal experience, the "-l80"
> > parameter is doing a lot of harm.  It causes things like
> > 
> > 	if (...)
> > 		for (...)
> > 			while (...)
> > 				if (...)
> > 					for (...)
> > 						while (...)
> > 							some_function(argument,
> > 									very_long_argument,
> > 									another_argument,
> > 									0,
> > 									1,
> > 									NULL
> > 									);
> 
> ... show up as unreadable crap they are.  I fail to see a problem...
> Fix them and run Lindent again, that's it.

Without -l80, this crap takes up fewer lines.  Such things usually
occur in 500+ line functions, not counting Lindent expansion.  Getting
a fair amount of those lines on the screen helps when fixing things
up.

But that's just my personal approach.  As long as the results are
sane, it doesn't really matter.

> Lindent behaviour wrt labels is far more annoying, ditto for the mess it
> often makes out of prototypes (demonstrated in the patch in question).
> 
> IME the best way to use Lindent is to do vi -c 's/[[:space:]]*$//|x' foo.c
> first, then run Lindent, then walk through prototypes and fix them,
> diff with pre-Lindent version and see if it looks sane...

You're lucky.  I've had to deal with code where the diff with
pre-Lindent version was completely pointless.  Original was so broken,
there was no room for regressions.

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
