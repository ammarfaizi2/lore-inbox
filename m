Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270090AbRHQKZt>; Fri, 17 Aug 2001 06:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270101AbRHQKZj>; Fri, 17 Aug 2001 06:25:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270090AbRHQKZf>; Fri, 17 Aug 2001 06:25:35 -0400
Subject: Re: initrd: couldn't umount
To: daniel.wagner@xss.co.at (Daniel Wagner)
Date: Fri, 17 Aug 2001 11:27:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Daniel Wagner" at Aug 17, 2001 12:06:01 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Xgr3-000775-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the problem is that a "rpciod" kernel-thread references the initrd,
> and so umounting and freeing it, isn't possible.
> 
> has anybody an idea how to fix this problem, cause it would be nice,
> to free the initrd ram on a diskless node.

It shouldnt be keeping a reference. daemonize() should have dropped its
resources
