Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbTJ3IFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 03:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTJ3IFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 03:05:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:63647 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262236AbTJ3IFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 03:05:07 -0500
Message-ID: <3FA0C631.6030905@namesys.com>
Date: Thu, 30 Oct 2003 11:05:05 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org>
In-Reply-To: <20031030015212.GD8689@thunk.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>Keep in mind that just because Windows does thing a certain way
>doesn't mean we have to provide the same functionality in exactly the
>same way.
>
>Also keep in mind that Microsoft very deliberately blurs what they do
>in their "kernel" versus what they provide via system libraries (i.e.,
>API's provided via their DLL's, or shared libraries).
>
>At some level what they have done can be very easily replicated by
>having a userspace database which is tied to the filesystem so you can
>do select statements to search on metadata assocated with files. 
>

> We
>can do this simply by associating UUID's to files, and storing the
>file metadata in a MySQL database which can be searched via
>appropriate userspace libraries which we provide.
>  
>
What a performance nightmare.  Updating a user space database every time 
a file changes --- let's move to a micro-kernel architecture for all of 
the kernel the same day.....;-)

Not to mention that SQL is utterly unsuited for semi-structured data 
queries (what people store in filesystems is semi-structured data), and 
would only be effective for those fields that you require every file to 
have.

>Please do **not** assume that just because of the vaporware press
>releases released by Microsoft that (a) they have pushed an SQL Query
>optimizer into the kernel or that (b) even if they did, we should
>follow their bad example and attempt to do the same.  
>
>There are multiple ways of skinning this particular cat, and we don't
>need to blindly follow Microsoft's design mistakes.
>
>Fortunately, I have enough faith in Linus Torvalds' taste that I'm not
>particularly worried what would happen if someone were to send him a
>patch that attempted to cram MySQL or Postgres into the guts of the
>Linux kernel....  although I would like to watch when someone proposes
>such a thing!
>
>						- Ted
>
>
>  
>
How about you send him a patch that removes all of that networking stuff 
from the kernel and puts it into user space where it belongs.;-)  There 
was this Windows user on Slashdot some time ago who claimed that it 
wasn't just the browser that should be unbundled from the kernel, the 
whole networking stack was unfairly bundled and locked out the companies 
that used to provide DOS with networking stacks (the user didn't have in 
mind patching the windows kernel and recompiling, he really thought it 
should all be in user space).  Your kind of fellow.....

It is true that there are many features, such as an automatic text 
indexer, that belong in user space, but the basic indexes (aka 
directories) and index traversal code belong in the kernel.

-- 
Hans


