Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268700AbUIGWKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbUIGWKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUIGWKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:10:06 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:18960 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S268700AbUIGWJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:09:56 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: William Stearns <wstearns@pobox.com>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
Date: Wed, 8 Sep 2004 00:09:52 +0200
User-Agent: KMail/1.6.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com> <Pine.LNX.4.58.0409071658120.2985@sparrow>
In-Reply-To: <Pine.LNX.4.58.0409071658120.2985@sparrow>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409080009.52683.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 23.05, William Stearns wrote:
> somone wrote
> > "..." is pretty good, but I think it has been used by others, but I
> > really forget who.  I could live with "...", but I think "metas" and

In MS-DOS  you can do "cd ..." as a shortcut for ..\.. but only in the cd 
command. VMS used it with fileneme pattern matching to indicate a 
recursive search.

> 	Some trojans and rootkits have used it to store files;
> /usr/lib/... , /usr/doc/... , /usr/sbin/... , /usr/local/bin/... ,
> /dev/... , and /usr/include/... are used by bobkit.
> 	This might trigger false positives for rootkit detection tools
> like chkrootkit and rootkit-hunter.
> 	Cheers,
> 	- Bill

Rootkit detection tools need to be updated and improved regularly anyway. If 
you use old rootkit detection tools, it might be a bonus if you are reminded 
of that fact. That's a feature, not a bug.

Maybe file/./attribute then. /. on a file is currently meaningless. That does 
not avoid the unpleasant fact that has been brought up by others (only to be 
ignored), that the directory syntax does not allow metadata on directories.

I'm not convinced that totally transparent access to meta-data actually 
benefits anyone. If metadata is that useful (which I believe) it may well be
worth fixing those apps that need, and can use them. The rest should just
ignore it, even loose it. 

There are too many apps that will not work properly with the metadata as file 
semantics anyway. Implementing something that only works sometimes is not a 
good idea. A new API would work where you expect it to work, i.e. in new and 
fixed apps, just like ACL's and EA's. (Ok, the ACL's are effective 
everywhere, but they aren't copied to new files or even preserved when 
editing, so emacs and others needs some fixing  anyway).

-- robin
