Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273425AbRINQpZ>; Fri, 14 Sep 2001 12:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273427AbRINQpP>; Fri, 14 Sep 2001 12:45:15 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:25615 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S273425AbRINQpJ>; Fri, 14 Sep 2001 12:45:09 -0400
Date: Fri, 14 Sep 2001 17:45:31 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4, 2.4-ac and quotas
Message-ID: <Pine.LNX.4.33.0109141730410.30680-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm desperately looking for some recent documentation on quotas.

We've recently upgraded our two Debian potato fileservers to 2.4 and
2.4-ac (currently they're both running 2.4-ac so I can't check 2.4 atm)
and quotas have stopped working.

The quota package is 3.00pre01-7.bunk, and quotaon calls quotactl which
returns -1 ENOENT (No such file or directory), as it's looking for
aquota.user, evidently a "version 2 quota" (according to the edquota
manpage), and not falling back to the quota.user files which do exist.

So now we're essentially running without quota support :-(

On another computer (Debian woody) I've made an ext3 partition, touched
aquota.user and quotactl now returns -1 EINVAL (Invalid argument).

Please can anyone help? Should I switch to XFS and go back to a
2.4.5-based kernel?

Matt

