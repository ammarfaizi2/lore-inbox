Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWF2Egj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWF2Egj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 00:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWF2Egj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 00:36:39 -0400
Received: from xenotime.net ([66.160.160.81]:36527 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751718AbWF2Egj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 00:36:39 -0400
Date: Wed, 28 Jun 2006 21:39:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Matt LaPlante" <laplam@rpi.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Attack of "the the"s in /arch
Message-Id: <20060628213924.50f29a4a.rdunlap@xenotime.net>
In-Reply-To: <000001c69b31$64186160$fe01a8c0@cyberdogt42>
References: <000001c69b31$64186160$fe01a8c0@cyberdogt42>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 00:06:25 -0400 Matt LaPlante wrote:

> Hi All,
>   This is my first attempt at submitting a patch, so I apologize if I've
> broken any rules.  I started out looking for errors in KConfig text, and
> after finding one instance of the popular repetition "the the" I decided to
> grep for other occurrences.  To my surprise, I popped up quite a few of
> them!  The patch below corrects these typos across several files, both in
> source comments and KConfig files.  There is no actual code changed, only
> text.  Note this only affects the /arch directory, and I believe I could
> find many more elsewhere. :) I'm not submitting for inclusion yet, so I can
> get feedback incase I need to change my format.

Hi Matt,

The only problem that I see is that your mail client or server
breaks some (longer) lines where they should not be split,
so the patch cannot be applied with 'patch'.

E.g.:

> diff -ru a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
> b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
> --- a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c	2006-06-28
> 23:20:26.000000000 -0400
> +++ b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c	2006-06-28
> 23:45:49.000000000 -0400

Above should be 3 lines:
diff ...
--- ...
+++ ...

but it is broken into 6 lines.  Your options are (e.g.):

- use (some) Linux client to send email (not all are good for patches)
- on Windows:  use thunderbird or sylpheed or (last resort, not
  really good since it makes reviewing & sending feedback on patches
  more difficult on us) is to use attachments.  Please don't go for
  the last resort.

Sylpheed (sylpheed.good-day.net) supports inserting a file into
the email body, which is perfect (at least on Linux it does,
I hope that it does on Windows too).
Tbird is more of a problem, but can do done.  If you care to use
tbird, take a look at
http://mbligh.org/linuxdocs/Email/Clients/Thunderbird
and
http://lkml.org/lkml/2005/12/27/191
and
http://lists.osdl.org/pipermail/kernel-janitors/2006-June/006478.html
for details on how to use it (on Linux, hopefully Windows is
about the same).

Try not to use attachments...

Oh, there are other split lines in your patch.  After joining all of
the split lines (10-12 of them), the patch applies cleanly except
for one file.  I'm applying it to 2.6.17-git13.  What kernel version
did you use to make it?  You should use a very current version.

---
~Randy
