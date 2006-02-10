Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWBJPc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWBJPc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWBJPc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:32:28 -0500
Received: from eastrmmtao03.cox.net ([68.230.240.36]:43224 "EHLO
	eastrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932139AbWBJPc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:32:28 -0500
Date: Fri, 10 Feb 2006 10:32:23 -0500
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, tytso@mit.edu,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210153223.GA27599@pe.Belkin>
References: <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com> <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ECADA8.9030609@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 09:13:44AM -0600, Christopher Friesen wrote:
> Joerg Schilling wrote:
> >"Christopher Friesen" <cfriesen@nortel.com> wrote:
> 
> >>There's nothing there that says the mapping cannot change with 
> >>time...just that it has to be unique.
> >
> >
> >If it changes over the runtime of a program, it is not unique from the
> >view of that program.
> 
> That depends on what "uniquely identified" actually means.

"The st_ino and st_dev fields taken together uniquely identify the
file within the system."

> One possible definition is that at any time, a particular path maps to a 
> single unique st_ino/st_dev tuple.

The quoted sentence certainly implies _at_least_ that much.

> The other possibility (and this is what you seem to be advocating) is 
> that a st_ino/st_dev tuple always maps to the same file over the entire 
> runtime of the system.

However, I don't think this is a reasonable interpretation, and it's
clearly _not_ the one that Joerg is implying.

Joerg is claiming that the quoted sentence also implies that
_different_ st_ino/st_dev pairs will _always_ identify different
files.  Taken in just the immediate context of stat.h, this is a
very reasonable interpretation.

> This second possibility seems easily disproved.  If you delete and 
> recreate files on a filesystem (assuming nobody has open files in the 
> filesystem), at some point a new file will end up with the same inode as 
> an old (deleted) file.  The two files are different, but have the same 
> st_ino/st_dev tuple.
> 
> This leaves the first possibility as the only choice...

If you want to show that his interpretation is incorrent (which it
may be for all I know), you need a better argument than this.

-chris

> 
> Chris
