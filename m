Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265261AbUFWLL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbUFWLL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 07:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUFWLL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 07:11:28 -0400
Received: from [217.73.129.129] ([217.73.129.129]:55957 "EHLO
	car.linuxhacker.ru") by vger.kernel.org with ESMTP id S265261AbUFWLLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 07:11:25 -0400
Date: Wed, 23 Jun 2004 14:11:15 +0300
Message-Id: <200406231111.i5NBBFwF201534@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Strange NOTAIL inheritance behaviour in Reiserfs 3.6
To: mtk-lists@jambit.com, linux-kernel@vger.kernel.org
References: <041c01c45875$0368e340$c100a8c0@wakatipu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

"Michael Kerrisk" <mtk-lists@jambit.com> wrote:

MK> On a Reiserfs 3.6 file system, I create a directory with the NOTAIL
MK> attribute set and create 10000 1-byte files in that directory.  lsattr(1)
MK> shows that the NOTAIL attribute is set on (i.e., inherited by) all of the
MK> files.  However, the disk space consumption remains small (certainly not
MK> 10000 blocks used).  Only when I explicitly set the NOTAIL attribute on all
MK> the files does disk consumption rise to what I would expect.  In other
MK> words, the files are inheriting the NOTAIL attribute form their parent
MK> directory, but this inheritance has no effect.

I believe there is user error on your part. Extended inode attributes
are disabled by default on reiserfs.

MK> Detailed example follows:

MK>     # mount -t reiserfs /dev/hda12 /testfs

Does it work as expected if you add "-o attrs" to the mount command?

Bye,
    Oleg
