Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVFNAJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVFNAJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVFNAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:09:50 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:60803 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261588AbVFNAIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 20:08:53 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <42AE1EE4.5090508@namesys.com>
Date: Mon, 13 Jun 2005 17:03:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: fs <fs@ercist.iscas.ac.cn>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       viro VFS <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <42ADFFD5.1090905@suse.com>
In-Reply-To: <42ADFFD5.1090905@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, would you be willing to make a proposal for what should be done? 
I would be interested in your suggestions.

Jeff Mahoney wrote:

>
> Hans -
>
> These tests must have been run on a kernel prior to 2.6.10-rc1. The I/O
> error code exhibits behavior similar to ext3, so (1b). There are still
> kinks to be worked out, but it's definitely not the "throw up our arms
> and give up" that it used to be.
>
> Implementing behavior 1a for ext3 and reiserfs should be fairly trivial
> - it just means that tests to check if the filesystem is in an aborted
> state ("shutdown" in xfs terms) need to added to the call path in some
> places, and be moved earlier in others.
>
> -Jeff
>
> --
> Jeff Mahoney
> SuSE Labs

