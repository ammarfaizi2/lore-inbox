Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTJ3CD1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 21:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTJ3CD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 21:03:27 -0500
Received: from h1ab.lcom.net ([216.51.237.171]:16771 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S262115AbTJ3CDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 21:03:25 -0500
Date: Wed, 29 Oct 2003 20:03:18 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: "Theodore Ts'o" <tytso@mit.edu>, Erik Andersen <andersen@codepoet.org>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031030020317.GE3094@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Erik Andersen <andersen@codepoet.org>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030015212.GD8689@thunk.org>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Theodore Ts'o on Wednesday, 29 October, 2003:
>Keep in mind that just because Windows does thing a certain way
>doesn't mean we have to provide the same functionality in exactly the
>same way.
>Also keep in mind that Microsoft very deliberately blurs what they do
>in their "kernel" versus what they provide via system libraries (i.e.,
>API's provided via their DLL's, or shared libraries).

Indeed, although certain things could be half-kernel, half-user
  (OK, 0.01% kernel, 99.99% user, e.g. userspace daemon that
  intercepts certain writes).  Of course, at that point, you might
  make a special library to interact with the daemon directly, although
  it's then not at all like just calling write().

Actually, thinking about it, it's ideal to have as a pluggable userspace
  daemon: on open() or a little after, determine the filetype, and forward
  interactions to a module/plugin that knows how to deal with that
  data format.  The plugin then calls some under-process (either back to
  the daemon or some other thing) to then archive off the information.

>At some level what they have done can be very easily replicated by
>having a userspace database which is tied to the filesystem so you can
>do select statements to search on metadata assocated with files.  We
>can do this simply by associating UUID's to files, and storing the
>file metadata in a MySQL database which can be searched via
>appropriate userspace libraries which we provide.
>
>Please do **not** assume that just because of the vaporware press
>releases released by Microsoft that (a) they have pushed an SQL Query
>optimizer into the kernel, or that (b) even if they did, we should
>follow their bad example and attempt to do the same.  

Indeed.  I prefer to keep my crashes in userspace.  :)

>There are multiple ways of skinning this particular cat, and we don't
>need to blindly follow Microsoft's design mistakes.

Amen, my brother!  ;)

>Fortunately, I have enough faith in Linus Torvalds' taste that I'm not
>particularly worried what would happen if someone were to send him a
>patch that attempted to cram MySQL or Postgres into the guts of the
>Linux kernel....  although I would like to watch when someone proposes
>such a thing!

heh.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
