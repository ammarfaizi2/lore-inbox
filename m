Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVE0R0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVE0R0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVE0R0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:26:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:4529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262523AbVE0R0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:26:47 -0400
Date: Fri, 27 May 2005 10:28:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sean <seanlkml@sympatico.ca>
cc: Jaroslav Kysela <perex@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Git Mailing List <git@vger.kernel.org>
Subject: Re: ALSA official git repository
In-Reply-To: <3516.10.10.10.24.1117213207.squirrel@linux1>
Message-ID: <Pine.LNX.4.58.0505271026020.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>   
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <3516.10.10.10.24.1117213207.squirrel@linux1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 May 2005, Sean wrote:
> >
> > Now, arguably gitweb should ignore whitespace at the beginning, but
> > equally arguably your commits shouldn't have them either...
> 
> Perhaps git should enforce this?  Patch attached.
> 
> Remove leading empty lines from commit messages.
> 
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

I'm not sure.

The thing is, right now git allows binary commit messages if somebody
really wants to. Now, a lot of the _tools_ end up only printing up to the
first '\0' or something, but in general, maybe somebody actually wants to
embed his own strange stuff in there (eg use encryption but still use
standard git tools).

Which makes me worry. So I _do_ do whitespace cleanup in my "apply email 
patches" scripts, but I'm not sure whether the core should care about the 
data that people feed it, even for commit messages.

Opinions?

		Linus
