Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbSL3ESP>; Sun, 29 Dec 2002 23:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbSL3ESP>; Sun, 29 Dec 2002 23:18:15 -0500
Received: from windlord.Stanford.EDU ([171.64.13.23]:65207 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id <S266660AbSL3ESO>; Sun, 29 Dec 2002 23:18:14 -0500
To: Larry McVoy <lm@work.bitmover.com>
Cc: Felix Domke <tmbinc@elitedvb.net>, linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
References: <fa.f9m4suv.e6ubgf@ifi.uio.no>
	<ylfzsgi3jz.fsf@windlord.stanford.edu>
	<20021230034303.GA11425@work.bitmover.com>
In-Reply-To: <20021230034303.GA11425@work.bitmover.com> (Larry McVoy's
 message of "Sun, 29 Dec 2002 19:43:03 -0800")
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Sun, 29 Dec 2002 20:26:31 -0800
Message-ID: <yln0mogmiw.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Honest Recruiter,
 sparc-sun-solaris2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:
> On Sun, Dec 29, 2002 at 07:33:20PM -0800, Russ Allbery wrote:

>> <http://www.jwz.org/doc/tabs-vs-spaces.html>

> Quouting from that page:
>     That ensures that, even if I happened to insert a literal tab in the
>     file by hand (or if someone else did when editing this file earlier),
>     those tabs get expanded to spaces when I save. 

> If you are using a source management system, pretty much *any* source
> management system, doing this will cause all the lines to be "rewritten"
> if they had tabs.  The fact that this person would advocate changing
> code that they didn't actually change shows a distinct lack of clue.

Yeah, that recommendation always bugged me too.  I would never do that; if
you really want to enforce something like that, the proper place is in a
pre-checkin transform in your source management system so that everything
that actually hits the source management database has no tabs in it.  Not
in individual editors.

But the rest of the message is a good summary of the issues, as far as I'm
concerned.

I'll add one additional issue, and the one that bugs me the most in
practice about tabs.  Tabs make patches a pain in the neck to read,
because they change the indentation of the lines in a diff so that it no
longer matches the original indentation.  In particularly pathological
cases, they can even make an indented line even with an unintended line.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
