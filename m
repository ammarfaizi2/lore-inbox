Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTKENwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 08:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbTKENwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 08:52:11 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:3293 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S262906AbTKENwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 08:52:07 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Things that Longhorn seems to be doing right
Date: Wed, 5 Nov 2003 14:51:10 +0100
User-Agent: KMail/1.5.4
Cc: Nikita Danilov <Nikita@Namesys.COM>, "Theodore Ts'o" <tytso@mit.edu>,
       Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org,
       Timothy Miller <miller@techsource.com>
References: <3F9F7F66.9060008@namesys.com> <3FA6891A.3050400@techsource.com> <3FA75F97.3080508@namesys.com>
In-Reply-To: <3FA75F97.3080508@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311051451.10063.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 November 2003 09:13, Hans Reiser wrote:
> Timothy Miller wrote:
> > Nikita Danilov wrote:
> >> It is called "a directory". :) There is no crime in putting
> >>
> >> cc src/*.c
> >>
> >> into Makefile. I think that Hans' query-result-object denoting multiple
> >> objects is more like directory than single regular file.
> >
> > So a file system query that results in multiple files generates a
> > "virtual directory"?
>
> Remember that this code does not exist yet.....;-)
>
> Sounds like it might be a good way to do it though.

Yes and this also solves the "refine feedback" problem: Just return
sth. useful in the stat->nlink for that directory
or even create a new stat-like syscall.

Now the issuer can decide on ANY level, whether to refine the search or
accept the result to present it in a listing.

A proper replacement for nlink is looong overdue.

But even with the crappy one, we have now, it can be decided since a
list of 65K is too much for a proper selection and cannot be handled by
a user. Somebody even said that every search pattern revealing more
than 50 records is not refined enough.

PS: Hans, we just saved you the funding on this topic.

Regards

Ingo Oeser


