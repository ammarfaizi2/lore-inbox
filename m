Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290227AbSAOSEr>; Tue, 15 Jan 2002 13:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290225AbSAOSEb>; Tue, 15 Jan 2002 13:04:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290222AbSAOSEY>; Tue, 15 Jan 2002 13:04:24 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Why not "attach" patches?
Date: Tue, 15 Jan 2002 18:02:12 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a21qr4$36h$1@penguin.transmeta.com>
In-Reply-To: <005901c19dec$59a89e30$0201a8c0@HOMER>
X-Trace: palladium.transmeta.com 1011117849 4698 127.0.0.1 (15 Jan 2002 18:04:09 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Jan 2002 18:04:09 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <005901c19dec$59a89e30$0201a8c0@HOMER>,
Martin Eriksson <nitrax@giron.wox.org> wrote:
>Why do many of you not _attach_ patches instead of merging them with the
>mail? It's so much cleaner and easier to have a "xxx-yyy.patch" file
>attached to the mail which can be saved in an appropriate directory. Also,
>the whitespace is always retained that way.

Attached patches are _horrible_ once you have many patches that you want
to maintain in a sane way and apply in one go.

In particular, with in-line text patches, I can:

 - see the patch easily when reading email, without the need to do
   anything special to inspect the attachment, regardless of what email
   client I happen to use.

 - keep emails as emails, and save them to folders etc, without
   losing any information of where the patch came from, while at the
   same time the folders are _also_ the patch and work with standard
   tools like "diffstat".

 - easily just "reply" to the person, and quote the part of the patch
   I have problems with.

 - save all the emails I want to apply in one single email folder
   ("doit"), and do a simple

	patch -p1 < ~/doit

   to apply all of them at the same time.

Note that NONE of these are practical with attachments.

In short: if your mailer eats whitespace or causes similar corruption,
just FIX THE MAILER.  There is no excuse for a mailer that corrupts the
mail. 

And while attachments may _appear_ convenient, they most definitely are
not.  They require special care and cannot be batched or edited with
normal tools. 

That may not matter if you just have one or two patches a week to worry
about, but trust me - attachments are crap. Use them for binary data
that cannot be edited or combined, _not_ for stuff you expect to be able
to actually change and extract pieces of with regular tools.

		Linus
