Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTJXWVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJXWVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:21:10 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:61436 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262679AbTJXWVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:21:05 -0400
Date: Fri, 24 Oct 2003 15:20:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Frank Cusack <fcusack@fcusack.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: cset #'s stable?
Message-ID: <20031024222054.GB972@ip68-0-152-218.tc.ph.cox.net>
References: <20031021091347.A7526@google.com> <20031021095209.A32703@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021095209.A32703@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 09:52:09AM -0700, Chris Wright wrote:
> * Frank Cusack (fcusack@fcusack.com) wrote:
> > Are changeset #'s stable?
> > 
> > I'm specifically looking at linux-2.5/net/sunrpc/clnt.c,
> > "rev 1.1153.63.[123]" which I recorded earlier as 1.1153.48.[123].
> 
> No, they are not.  The key, however, is stable (bk changes -k -r<rev>,
> for example).

FWIW, it's easy to go back and forth as well, bash (pure sh?) functions
to do it:
REVTOKEY() {
	if [ -z "$1" ]; then
		echo "Usage: REVTOKEY revision-number"
	else
		if [ ! -f ChangeSet -a ! -f SCCS/s.ChangeSet ]; then
			echo "Must be run from the base of a BitKeeper repositor
y"
		else
			echo -n "The key is: "
			bk prs -r$1 -hnd:KEY: ChangeSet
		fi
	fi
}

KEYTOREV() {
	if [ -z "$1" ]; then
		echo "Usage: KEYTOREV key"
	else
		if [ ! -f ChangeSet -a ! -f SCCS/s.ChangeSet ]; then
			echo "Must be run from the base of a BitKeeper repositor
y"
		else
			echo -n "The key is: "
			bk prs -r$1 -hnd:REV: ChangeSet
		fi
	fi
}

-- 
Tom Rini
http://gate.crashing.org/~trini/
