Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWEDVnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWEDVnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWEDVnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:43:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57023 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751419AbWEDVnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:43:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <84144f020605040813q29fcddcr1c846d27cf156432@mail.gmail.com> 
References: <84144f020605040813q29fcddcr1c846d27cf156432@mail.gmail.com>  <20060504031755.GA28257@hellewell.homeip.net> <20060504034127.GI28613@hellewell.homeip.net> 
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 04 May 2006 22:43:23 +0100
Message-ID: <23514.1146779003@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> > +               rc = mapping->a_ops->readpage(file, page);
> 
> What's the purpose of this second read?

When writing CacheFiles, I noticed that ext3 would occasionally unlock a page
that had neither PG_uptodate nor PG_error set, and so I had to force another
readpage() on it.

David
