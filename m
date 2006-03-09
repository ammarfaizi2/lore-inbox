Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWCIXYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWCIXYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWCIXYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:24:21 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:57870 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932131AbWCIXYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:24:20 -0500
Date: Fri, 10 Mar 2006 00:24:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, rolandd@cisco.com, gregkh@suse.de,
       akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
Message-ID: <20060309232406.GA24991@mars.ravnborg.org>
References: <ac5354bb50d515de2a5c.1141922831@localhost.localdomain> <ada4q27ld33.fsf@cisco.com> <20060309185604.GA24004@mars.ravnborg.org> <adafylrigug.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adafylrigug.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 11:00:07AM -0800, Roland Dreier wrote:
>     Sam> Eventually - yes.  But not just now. Kbuild was introduced
>     Sam> because it was needed in the top-level directory and it made
>     Sam> good sense to do so.  But for now keeping Makefile is a good
>     Sam> choice. This is anyway what people are used to.
> 
> OK, disregard my suggestion then.  Should we patch
> Documentation/kbuild/makefiles.txt to correct the current
> documentation, which says:
> 
>   The preferred name for the kbuild files is 'Kbuild' but 'Makefile'
>   will continue to be supported. All new developmen is expected to use
>   the Kbuild filename.

I've just checked in the following patch:

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 99d51a5..a9c00fa 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -106,9 +106,9 @@ This document is aimed towards normal de
 Most Makefiles within the kernel are kbuild Makefiles that use the
 kbuild infrastructure. This chapter introduce the syntax used in the
 kbuild makefiles.
-The preferred name for the kbuild files is 'Kbuild' but 'Makefile' will
-continue to be supported. All new developmen is expected to use the
-Kbuild filename.
+The preferred name for the kbuild files are 'Makefile' but 'Kbuild' can
+be used and if both a 'Makefile' and a 'Kbuild' file exists then the 'Kbuild'
+file will be used.
 
 Section 3.1 "Goal definitions" is a quick intro, further chapters provide
 more details, with real examples.
