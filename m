Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbSL3XDU>; Mon, 30 Dec 2002 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbSL3XDU>; Mon, 30 Dec 2002 18:03:20 -0500
Received: from netrealtor.ca ([216.209.85.42]:33809 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267101AbSL3XDO>;
	Mon, 30 Dec 2002 18:03:14 -0500
Date: Mon, 30 Dec 2002 18:20:08 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Larry McVoy <lm@work.bitmover.com>, Russ Allbery <rra@stanford.edu>,
       Felix Domke <tmbinc@elitedvb.net>, linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
Message-ID: <20021230232007.GA30238@mark.mielke.cc>
References: <fa.f9m4suv.e6ubgf@ifi.uio.no> <ylfzsgi3jz.fsf@windlord.stanford.edu> <20021230034303.GA11425@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230034303.GA11425@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 07:43:03PM -0800, Larry McVoy wrote:
> > <http://www.jwz.org/doc/tabs-vs-spaces.html>
> Quouting from that page:
>     That ensures that, even if I happened to insert a literal tab in the
>     file by hand (or if someone else did when editing this file earlier),
>     those tabs get expanded to spaces when I save. 

> If you are using a source management system, pretty much *any* source
> management system, doing this will cause all the lines to be "rewritten"
> if they had tabs.  The fact that this person would advocate changing
> code that they didn't actually change shows a distinct lack of clue.
> No engineer who works for an even semi-pro company would dream of doing
> this.  At BitMover, anyone who seriously advocated this for more than
> a day would be fired.

Disagreeing with that slightly - there is middle ground, but it needs
to be explicit, or at least source file type dependent. For example,
whitespace on the *end* of a line containing text can almost always be
stripped. I've had far more trouble than its worth of designers
submitting code that accidentally included whitespace at the end of
lines. They didn't even *intend* to change the line, or when they made
a change, and restored the original code, they unintentionally left
whitespace on the end. Later on in the development process, this
seemingly insignificant difference becomes significant when two
functional equivalent lines trigger to the source manager as segment
that requires a complex merge operation.

The middle ground takes the form 'this is a common mistake people make
for this specific project, and as a business case, it makes a lot more
sense to quietly handle the situation automatically.' Some design
groups force their source to be put through a mandatory automatic code
beautification/styler process during submission. As the customer, and
as the people directly familiar with the problems they experience, and
the responsibility for their choice, they *should* have the choice to
enable a process such as is described in the above URL (expanding
leading tabs to whitespace on submission).

The alternative, of course, is the choice that Linux takes. If it doesn't
meet the appropriate requirements, it doesn't get submitted.

The source manager is supposed to help you, not hinder you. For very common
situations, where responsibility for consequences can be accepted, the
source manager *should* provide the means to perform transformations of the
source code upon submission.

Firing an employee for suggesting this seems a little extreme... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

