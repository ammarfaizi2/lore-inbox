Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUILUnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUILUnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 16:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUILUnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 16:43:08 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:42084 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261426AbUILUnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 16:43:01 -0400
Message-ID: <bbc62616040912134378daa6b5@mail.gmail.com>
Date: Sun, 12 Sep 2004 22:43:00 +0200
From: Davide Inglima <limacat@gmail.com>
Reply-To: Davide Inglima <limacat@gmail.com>
To: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea ofwhat reiser4 wants to do with metafiles and why
In-Reply-To: <4140ABB6.6050702@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com>
	 <Pine.LNX.4.58.0409071658120.2985@sparrow>
	 <200409080009.52683.robin.rosenberg.lists@dewire.com>
	 <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 12:15:02 -0700, Hans Reiser <reiser@namesys.com> wrote:
> Putting \ into filenames makes windows compatibility less trivial.
> Putting | into filenames seems like asking for trouble with shells.
> Asking users to keep track of multiple levels of escapes imposed by
> shells and such is hard on them.
 
> If you think \| is user friendly, oh god, people like you are the reason
> why Unix is hated by many.
 
> Having to explain filename/metas/owner or filename/.../owner or
> filename/..metas/owner (I don't deeply care what string is used in place
> of "metas") is hard enough.

[Sorry if the tone of this e-mail is particularly heated. I used to
use reiserfs and I am really looking towards the insertion of the
final version of reiser4 in the linux kernel, but I wish to publish my
2 cents as user (not as kernel developer). TIA for your attention and
patience in advance...]

The idea of using "metas" (instead of ".metas" and "..metas") however
is ATROCIOUS, as it would mean to have a fine "metas" entry popping up
in every dir, be undeletable, and having some random user pissed at
his random ${OS} because "it puts stuff that does not belong in the
system"...

The main idea about metadata is that you should be able to use
metadata only if you care. And if you use something, THEN you need to
be bugged by its presence but in a way that does not bug everyone's
else... 99% of people out there only care to use metadatas only via
those kind of applications that _really_ support it, like Mp3 players,
Torrentlike apps and CVS-like programs (if they do and really care to
have their metadatas consistent with the reality, that is [1]).

It has no sense for a human being to go and manage thousands of
metadata directories by hand, hence having "metas" right there in the
filesystem is not calling for user-friendlyness... it is only
desperately calling for some n00b# to dd inside it "just for fun" or
"just to make it go away". Putting in the spotlight a potentially
unreliable OR fragile source of informations is only asking for
trouble and is also harrassing for the end-user that couldn't care
less about that "metas" stuff. (what is this metas stuff that is
between my mariah999.jpg and morena001.jpg in my pr0n/ folder? [2])

In the end, using a UNIX-flavoured system matters because things are
shaped to help sysadmin's jobs, and sysadmins are asked for their task
to Read The Finely-written (?) Manuals before inserting the root
password at the login prompts.

The end-users are to be protected from themselves until they are
really ready to read the documentation.

In conclusion: I don't know WAFL, but I won't make Clearcase example a
too forward example... Clearcase naming is useful only inside a
Clearcase-enabled environment and using Clearcase-enabled tools... I
don't think that people at IBM are going to flame me or handle me a
DMCA takedown notice if I put on my filesystem filenames that could
possibly conflict with their system. Instead Reiserfs4 is going to ask
me to sacrifice a viable word for my filenames (no, I don't call my
filenames .something), and to create a workaround for my scripts [3]
while an alternative like .metas or a ..metas would make even more
sense and be more streamlined with Linux/UNIX customs.

Just my 2 cents as random n00b.

Ciao :)
-- 
Davide Inglima

[1] http://www.well.com/~doctorow/metacrap.htm
[2] whoops...
[3] ls -1 | wc -l
