Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267854AbTBKNuo>; Tue, 11 Feb 2003 08:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267856AbTBKNuo>; Tue, 11 Feb 2003 08:50:44 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:65290 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267854AbTBKNum>; Tue, 11 Feb 2003 08:50:42 -0500
Date: Tue, 11 Feb 2003 14:59:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dave Jones <davej@codemonkey.org.uk>
cc: Bill Davidsen <davidsen@tmr.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: the modules problems
In-Reply-To: <20030211013521.GA23638@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.44.0302111053440.32518-100000@serv>
References: <3E471F21.4010803@wirex.com> <Pine.LNX.3.96.1030210170713.29699C-101000@gatekeeper.tmr.com>
 <20030211013521.GA23638@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Feb 2003, Dave Jones wrote:

>  > Too radical? After the modules rewrite how could anything short of a
>  > rewrite in another language be too radical.
> 
> The modules rewrite highlighted a *lot* of bugs, which had nothing
> to do with modules whatsoever. It was unfortunate for Rusty that his
> work got merged the same time as a lot of other changes went in
> which broke a lot of stuff (The cli/sti stuff springs to mind).
> It also highlighted another bunch of bugs which were *real problems*
> like using code marked __init after it was freed.

All this could have been done without a complete rewrite.

> The "This doesn't compile, Rusty sucks" brigade then appeared,
> not taking a second to realise that said driver was fscked regardless
> of Rusty's code being merged.
> 
> Sure the modules rewrite wasn't painless, and like everything that
> gets merged, there were bugs, but give the guy a break already.[1]
> If there are still problems with modules, let Rusty know about it.
> If not, please STFU already, its getting tiring hearing the same
> old FUD.

Dave, it's really not that simple. Sure, there were bugs misattributed to 
the modules rewrite, but these are usually easy to identify and can be 
forwarded to the right culprit.
This leaves us with the real module problems and the biggest is an 
unresponsive modules maintainer, when it comes to serious criticism. I'm 
not the only one, whose questions are ignored. Rusty somehow assumes 
nobody would understand his brilliant ideas (1), so we have to live 
"executive summaries" (2). Sorry, but this is fucking arrogant and this 
slowly really pisses me off.
The modules rewrite has some serious problems and so far I haven't found 
an explaination, how they will be addressed. Feel free to flame me if the 
solutions is so obvious that my little mind couldn't grasp it.
The biggest problem which doesn't let me look forward to 2.6 regarding 
modules are the user visible changes - the new module tools. Why wasn't it 
possible to update modutils? The new modprobe.conf is far less powerful 
and I don't really want to know what tricks distributions will come up 
with to keep modules.conf and modprobe.conf in sync.
request_module() is still broken, because modprobe/insmod does not 
synchronise multiple calls. The module tools are still experimental at 
best. I posted a patch to keep both tools working (no reaction of course).
I could go on with various other (serious) design problems, but I 
mentioned most of them already in other mails, again without any reaction 
from Rusty. I'd really like to know, why I'm not worth an answer anymore. 
I'd really like to help, but ignoring me doesn't solve anything, I 
wouldn't be that insistent, if I wouldn't see some real problems, I don't 
do this just to annoy Rusty. Either these problems are real, then they 
should be addressed somehow or I'm wrong, but then I'd like to know why 
and I had no problem to admit mistakes. If there are multiple possible 
solutions, we should at least consider all possible advantages/ 
disadvantages.
I'm really annoyed with this situation and if Rusty doesn't want to 
cooperate, I slowly think it's the best solution to just revert the whole 
mess and just port the few good things. The old module support isn't 
perfect, but at least we know its problems and can address them one by 
one.

bye, Roman

(1) http://marc.theaimsgroup.com/?l=linux-kernel&m=104440182324752&w=2
(2) http://marc.theaimsgroup.com/?l=linux-kernel&m=104261939523782&w=2

