Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUH0LiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUH0LiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 07:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUH0LiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 07:38:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:3741 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262085AbUH0Lho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 07:37:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16687.7416.393210.981773@alkaid.it.uu.se>
Date: Fri, 27 Aug 2004 13:37:28 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Gergely Tamas <dice@mfa.kfki.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: data loss in 2.6.9-rc1-mm1
In-Reply-To: <20040827105543.GA10563@mfa.kfki.hu>
References: <20040827105543.GA10563@mfa.kfki.hu>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gergely Tamas writes:
 > Hi!
 > 
 > I've hit the following data loss problem under 2.6.9-rc1-mm1.
 > 
 > If I copy data from a file to another the target will be smaller then
 > the source file.
 > 
 > 2.6.9-rc1 does not have this problem
 > 2.6.8.1-mm4 does not have this problem
 > 2.6.9-rc1-mm1 _does have_ this problem
 > 
 > I tried this with reiserfs and xfs and it happened with both of them.

I also saw weird errors when I (very briefly) ran 2.6.9-rc1-mm1
on my News server.
- scp of a newly created file to another box failed with an I/O error
- md5sums of newly created files were incorrect
- NFS mount request to this box failed with permission denied

I don't have time to investigate further, but I've experienced no
problems with either 2.6.9-rc1 or 2.6.8.1-mm4. All local file
systems were ext3, btw.

/Mikael
