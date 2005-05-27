Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVE0Srj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVE0Srj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVE0Src
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:47:32 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56199 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262507AbVE0SrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:47:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sean <seanlkml@sympatico.ca>, Jaroslav Kysela <perex@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: ALSA official git repository
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
	<3516.10.10.10.24.1117213207.squirrel@linux1>
	<Pine.LNX.4.58.0505271026020.17402@ppc970.osdl.org>
From: Junio C Hamano <junkio@cox.net>
Date: Fri, 27 May 2005 11:47:21 -0700
In-Reply-To: <Pine.LNX.4.58.0505271026020.17402@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 27 May 2005 10:28:44 -0700 (PDT)")
Message-ID: <7vvf54y092.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Fri, 27 May 2005, Sean wrote:
>> >
>> > Now, arguably gitweb should ignore whitespace at the beginning, but
>> > equally arguably your commits shouldn't have them either...
>> 
>> Perhaps git should enforce this?  Patch attached.
>> 
>> Remove leading empty lines from commit messages.
>> 
>> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

LT> I'm not sure.
LT> Opinions?

Porcelains and gitweb should play with each other nicely, but
the core should _not_ care by default.

An extra option ("--text", perhaps) to git-commit-tree is
acceptable to me, and it may be even a good thing to have.  It
would make life a bit easiear for Porcelain writers if nothing
else.  If that is to happen, I would say we could do more than
just leading blank line removal.  We can also remove trailing
blanks before each LF, tabify indented log message contents, and
remove empty lines before EOF.

