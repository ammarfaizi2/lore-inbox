Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271147AbRHOLiX>; Wed, 15 Aug 2001 07:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271149AbRHOLiN>; Wed, 15 Aug 2001 07:38:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58377 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271147AbRHOLiD>; Wed, 15 Aug 2001 07:38:03 -0400
Subject: Re: 2.4.8 Resource leaks + limits
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 15 Aug 2001 12:40:03 +0100 (BST)
Cc: mag@fbab.net, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Linus Torvalds" at Aug 14, 2001 10:32:16 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Wz1n-00033Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux has had (for a while now) a "struct user" that is actually quickly
> accessible through a direct pointer off every process that is associated
> with that user, and we could (and _will_) start adding these kinds of
> limits. However, part of the problem is that because the limits haven't
> historically existed, there is also no accepted and nice way of setting
> the limits.

For that to work we need to seperate struct user from the uid a little, or
provide heirarchical pools (which seems overcomplex). Its common to want
to take a group of users (eg the chemists) and give them a shared limit
rather than per user limits

Alan
