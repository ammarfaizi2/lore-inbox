Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbUFOTGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUFOTGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUFOTCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:02:39 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:61145 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S265865AbUFOTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:02:13 -0400
Date: Tue, 15 Jun 2004 14:01:15 -0500
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: File Corruption Linux -> Novell NFS
Message-ID: <20040615190114.GA13756@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the XFS/NFS issue got resolved, I was able to focus my testing to the
other NFS corruption I was seeing. All the test does is copy a file to
novell, then compares the remote copy to the local (XFS fs) one. The corruption only
occurs sometimes and tends to be on an 8k boundary, but not always.  And
NO, this is not a network problem, since I don't see the corruption on a
FreeBSD (FreeBSD->novell NFS) box which is on the same network.  I have also
seen it on systems with different network cards (intel and broadcom gigabit
cards).  I have seen this on kernels 2.4.22 & 2.4.26.

Another problem I see is when deleting from an NFS mounted tru64 system.  I
often get a "no such file or directory" error when I delete the file even
though a ls right before the delete shows the file there.  And after the
delete, the file is no longer in the directory, even though the delete
claimed the file wasn't there, it still deleted the file.  I have not seen
file corruption to a tru64 box.

Andy
