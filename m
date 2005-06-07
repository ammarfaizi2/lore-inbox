Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVFGVrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVFGVrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVFGVrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:47:45 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:42375 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261297AbVFGVrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:47:43 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: RFC: i386: kill !4KSTACKS
From: Alexander Nyberg <alexn@telia.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <20050607212706.GB7962@stusta.de>
References: <20050607212706.GB7962@stusta.de>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 23:47:38 +0200
Message-Id: <1118180858.956.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-06-07 klockan 23:27 +0200 skrev Adrian Bunk:
> 4Kb kernel stacks are the future on i386, and it seems the problems it 
> initially caused are now sorted out.
> 
> I'd like to:
> - get a patch into the next -mm that unconditionally enables 4KSTACKS
> - if there won't be new reports of breakages, send a patch to
>   completely remove !4KSTACKS for 2.6.13 or 2.6.14
> 

Combinations of IDE/SCSI with MD/DM (maybe even stacking them ontop of
eachother), NFS and a filesystem in there breaks 4KSTACKS which is a
known issue so you can't just remove it leaving users with no choice.

This was not even difficult to trigger a while ago and I haven't seen
any stack reduction patches in these areas.

