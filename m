Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTLAQgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 11:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTLAQgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 11:36:12 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:43762 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263742AbTLAQgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 11:36:10 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: David Lang <david.lang@digitalinsight.com>,
       =?CP 1252?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: OT: why no file copy() libc/syscall ??
Date: Mon, 1 Dec 2003 10:20:18 -0600
X-Mailer: KMail [version 1.2]
Cc: Nick Piggin <piggin@cyberone.com.au>,
       "Robert White <rwhite@casabyte.com> \"'Florian Weimer'\"" 
	<fw@deneb.enyo.de>,
       Valdis.Kletnieks@vt.edu, "'Daniel Gryniewicz'" <dang@fprintf.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com> <20031127100217.GA9199@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0311270253130.6400@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.58.0311270253130.6400@dlang.diginsite.com>
MIME-Version: 1.0
Message-Id: <03120110201800.12834@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 04:58, David Lang wrote:
[snip]
> actually thinking about it a bit more, did I make a stupid mistake and
> think that the FD points at the beginning of the file when it really
> points at the inode? if it points at the inode then the problems I was
> refering to don't exist.

Actually, it points to inode and offset in the file. The advantage this has
is in the case of appending to a file... open the destination file, seek to
the end, then copy. It also allows seeking some offset in the input file,
then copying the rest of the file.
