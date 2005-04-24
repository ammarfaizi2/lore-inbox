Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVDXPL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVDXPL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVDXPL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:11:28 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:19910 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S262338AbVDXPLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:11:08 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Linux 2.6.12-rc3
To: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sun, 24 Apr 2005 17:10:07 +0200
References: <3VIcq-8ls-9@gated-at.bofh.it> <3VIFr-px-7@gated-at.bofh.it> <3VMJj-3Hv-61@gated-at.bofh.it> <3VThx-16N-7@gated-at.bofh.it> <3VUnf-1Ua-21@gated-at.bofh.it> <3WfL8-33i-15@gated-at.bofh.it> <3WgH8-3LO-3@gated-at.bofh.it> <3WqZS-3qK-21@gated-at.bofh.it> <3WtEl-5Ao-11@gated-at.bofh.it> <3WBVe-3Qn-11@gated-at.bofh.it> <3WIaj-8vN-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DPikK-0000sV-SD@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:

> Feel free to make it better, I have never claimed to be a bash
> programmer :)

Just some basic comments:

> #!/bin/bash

set -e

> DIR=$1
> 
> mkdir $DIR
> cd $DIR
[...]

General rule: _*Allways*_ use quotes for variable expansion.

Reason:

$ md foo\ bar
$ DIR=Foo\ bar
$ cd $DIR
bash: cd: foo: No such file or directory

-- 
Top 100 things you don't want the sysadmin to say:
70. Hmm, maybe if I do this...

