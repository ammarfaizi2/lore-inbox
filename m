Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTIUEi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 00:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTIUEi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 00:38:26 -0400
Received: from web20706.mail.yahoo.com ([216.136.226.179]:64332 "HELO
	web20706.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262327AbTIUEiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 00:38:25 -0400
Message-ID: <20030921043824.9720.qmail@web20706.mail.yahoo.com>
Date: Sat, 20 Sep 2003 21:38:24 -0700 (PDT)
From: Binny Gill <kernelwise@yahoo.com>
Subject: Attributes returned by NFS Readdirplus not utilized?
To: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
In-Reply-To: <20030920123944.GA2378@kiwi.hjbaader.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Trond,

I am working with the patch to make readdirplus work for NFSv3 client in linux 2.4.18

I noticed that the attributes returned are mostly thrown away as the fattr->timestamp 
that they get during nfs_cached_lookup() is the mtime of the directory (which is normally way in
the past for directories that dont change that often). I was wondering why we cannot store the 
time the readdirplus results were received in the cache and use that as the fattr->timestamp. 

I would like to use '1 readdirplus' to serve a 'ls -la'. Currently it is more like
'1 readdirplus + getattrs for each child'. Am I missing something here?

Regards,
Binny


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
