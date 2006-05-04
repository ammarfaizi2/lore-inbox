Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWEDMRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWEDMRV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 08:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWEDMRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 08:17:21 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:10725 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932069AbWEDMRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 08:17:20 -0400
X-ORBL: [69.149.117.205]
Date: Thu, 4 May 2006 07:11:59 -0500
From: Michael Halcrow <lkml@halcrow.us>
To: Pavel Machek <pavel@ucw.cz>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/13: eCryptfs] Documentation
Message-ID: <20060504121159.GB9194@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20060504031755.GA28257@hellewell.homeip.net> <20060504033534.GA28613@hellewell.homeip.net> <20060504073222.GD5359@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504073222.GD5359@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 07:32:22AM +0000, Pavel Machek wrote:
> > +The operation will complete.  Notice that there is a new file in
> > +/root/crypt that is 2 pages (8192 bytes) in size.  This is the
> 
> Not 12K and or 8K+strlen('hello world')?

We missed this update in the documentation when we made the recent
change to the header; it should read:

---
The operation will complete.  Notice that there is a new file in
/root/crypt that is at least 12288 bytes in size (depending on your
host page size).  This is the encrypted underlying file for what you
just wrote.  To test reading, from start to finish, you need to clear
the user session keyring:
---

Mike
