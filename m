Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUAZTid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUAZTid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:38:33 -0500
Received: from hera.kernel.org ([63.209.29.2]:30914 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265117AbUAZTic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:38:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PATCH to access old-style FAT fs
Date: Mon, 26 Jan 2004 19:38:11 +0000 (UTC)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <bv3qb3$4lh$1@terminus.zytor.com>
References: <20040126173949.GA788@frodo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1075145891 4785 66.80.2.163 (26 Jan 2004 19:38:11 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 26 Jan 2004 19:38:11 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: hpa@smyrno.(none) (H. Peter Anvin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040126173949.GA788@frodo.local>
By author:    Frodo Looijaard <frodol@dds.nl>
In newsgroup: linux.dev.kernel
> 
> Hi folks,
> 
> I have created and attached a new version of my old-style FAT filesystem
> patch, this time for the 2.6.0 kernel. It can also be found on
> http://debian.frodo.looijaard.name/. 
> 
> Some old implementation of the FAT standard mark the end of the
> directory file index by inserting a filename beginning with a byte 00.
> All entries after it should be ignored, even though they are not marked
> as deleted. At least some EPOC releases (an OS used on Psion PDAs, for
> example) still use this policy.
> 

It's not just "old implementations" -- it's the spec.

After reaching a filename beginning with 00, no further data should be
assumed to be in that filesystem.  MS-DOS itself would only do that
when formatting the filesystem, so *all* the subsequent entries would
be assumed to start with 00, but that doesn't really seem to be to
spec.

	-hpa
