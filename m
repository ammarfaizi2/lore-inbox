Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVDIV6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVDIV6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 17:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDIV6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 17:58:52 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:12782 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261390AbVDIV6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 17:58:49 -0400
Date: Sat, 9 Apr 2005 14:58:40 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, marcelo@hera.kernel.org, greg@kroah.com,
       chrisw@osdl.org
Subject: Unified changelogs for parsing by scripts
Message-ID: <20050409215840.GA14253@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew, Marcelo, Greg, Chris, and folks,

Since the SCM situation is changing, I thought I'd put in a word for those of us
who like parsing changelogs via scripts. Hopefully the loss of BitKeeper will
not involve a loss of detail in the changelogs as well. Maybe the changelogs
could even be improved now.

I parse the 2.6 and 2.4 changelogs, including all -pre, -rc, and w.x.y.z
kernels, and I find that there's a wide variety of formatting that's been
used over the past few years. This makes it impossible to produce a working
web application for outside consumption, because I can never tell when the
whole thing will break because of some new anomaly.

So this email is to make some of the following suggestions for future changelog
formats:

1) the date of the particular entry, the date of the kernel release, the full
name (if available) of the author of the patch, the email of the author of
the patch, and the changelog entry itself should all have specific, easily
parsable locations. The start of each entry should also be completely
unambiguous.

2) there should be no extraneous information (i.e. nothing other than changelog
entries) in the file. (no version number header at the top of the file, no
multiple changelogs for multiple kernel releases in the same file, no dashed
lines as line separators, etc). Or at least, extraneous data should be easily
siftable.

3) the changelog system for the kernel should standardize on what information
it contains, and where and how this information is delineated. Currently
for example, the 2.4 changelog is against the previous full release, rather
than the most recent -rc release; while the 2.6 changelog is against the
most recent -rc release. Whenever a new 2.4 kernel comes out, I have to extract
the -rc changelog information from it, then go in by hand and date them all
by looking at mailing list archives. There are also tons of special cases,
especially in the earlier days of BitKeeper, oddly formatted entries, entries
with some kinds of information in one part of the file, and different
information in another. It's a mess.

4) the locations of changelogs on kernel.org should be completely predictable
programmatically.

5) when the format of changelogs changes, all previous changelogs should be
regenerated in the new format. There should be a mailing list for people
who would like to know in advance when the changelog format will change,
so they can update their web page CGI and not crash and burn.

All I'm really asking is that the various kernel maintainers recognize
that the issue exists, and take the opportunity, while changing version
control systems, to come up with a clean solution for those of us tracking
developments automatically. Or trying to.

Be well,
Zack

-- 
Zack Brown

