Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVDJRdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVDJRdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVDJRdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:33:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24236 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261529AbVDJRdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:33:25 -0400
Date: Sun, 10 Apr 2005 10:30:21 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       mingo@elte.hu, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050410103021.39eb6b2d.pj@engr.sgi.com>
In-Reply-To: <200504101022.j3AAMtg03784@blake.inputplus.co.uk>
References: <20050409173944.247252eb.pj@engr.sgi.com>
	<200504101022.j3AAMtg03784@blake.inputplus.co.uk>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph wrote:
> but good enough for
> most uses that people will get caught out when it fails.

Exactly.

If Linus persists in this diff-tree output format, using two lines for
changed files, then I will have to add the following sed script to my
arsenal:

  sed '/^</ { N; s/\n>/ / }'

It collapses pairs of lines:

<100664 4870bcf91f8666fc788b07578fb7473eda795587 Makefile
>100664 5493a649bb33b9264e8ed26cc1f832989a307d3b Makefile

to the single line:

<100664 4870bcf91f8666fc788b07578fb7473eda795587 Makefile 100664 5493a649bb33b9264e8ed26cc1f832989a307d3b Makefile

However, more people will get bit by this git glitch than know sed.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
