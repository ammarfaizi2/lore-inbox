Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUBJEje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 23:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbUBJEje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 23:39:34 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:14758 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265572AbUBJEjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 23:39:33 -0500
Date: Mon, 9 Feb 2004 20:39:26 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: 4.1GB limit with nfs3, 2.6 & knfsd?
Message-ID: <20040210043926.GG18674@srv-lnx2600.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to tar and bzip2 some directories over the weekend and I think
I may have found a bug.

The operation would consistantly fail when the bzip2ed tar file hit 4.1GB
when directed at a 2.6.1-bk2-nfs-stale-file-handles knfsd server from
another computer running the same kernel.

If I try the operation against a local filesystem, or a 2.4.24 knfsd server
on the network there are no failures and the file is at 18GB and growing on
the local filesystem (not enough space on the 2.4 server...).

This is all from the same nfs client computer.

I plan on doing some more tests with dd and cat against the server after the
files have finished compressing.

Anyone have any ideas?  I know this could be userspace, but why does it work
against a 2.4 knfsd and on the local filesystem?
