Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbUBPPzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUBPPzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:55:40 -0500
Received: from mail.shareable.org ([81.29.64.88]:14980 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265507AbUBPPzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:55:38 -0500
Date: Mon, 16 Feb 2004 15:55:34 +0000
From: Jamie Lokier <jamie@shareable.org>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <20040216155534.GA17323@mail.shareable.org>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr> <20040216062152.GB5192@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040216062152.GB5192@pegasys.ws>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> If you have a filesystem with filenames that don't conform
> to your policy write userspace tools to detect and/or fix
> them.  If you have programs creating non-conforming
> filenames, fix or rm those programs.

You do understand that GNU coreutils, bash etc. are among those
programs, right?  As in "touch zöe.txt" creates a non-conforming
filename...

> OK.  The questions have been asked and answered.
> Asking again and again and again won't change the answer.

The question of what a program like this should do has not been
answered:

   perl -e 'for (glob "*") { rename $_, "ņi-".$_ or die "rename: $!\n"; }'

   (NB: The prefix string is N WITH CEDILLA followed by "i-").

Hint: it mangles perfectly fine non-ASCII file names, instead of just
prefixing the prefix string.  If you change the program to correctly
prepend the prefix string, then it mangles non-UTF-8 names, which is
arguably correct, but can result in you losing some files.

This _is_ a userspace problem, but it is a genuine problem for which
no good answer is yet apparent.

-- Jamie
