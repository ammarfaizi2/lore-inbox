Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132077AbRDAJHB>; Sun, 1 Apr 2001 05:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRDAJGv>; Sun, 1 Apr 2001 05:06:51 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:26360 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S132077AbRDAJGd>;
	Sun, 1 Apr 2001 05:06:33 -0400
To: hbryan@us.ibm.com
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentation/ioctl-number.txt)
In-Reply-To: <OF791BBBC5.E3FCBEEE-ON87256A18.005BA3B7@LocalDomain>
From: chip@valinux.com (Chip Salzenberg)
Organization: NASA Calendar Research
Cc: linux-kernel@vger.kernel.org
Message-Id: <E14jdkF-0007Ps-00@tytlal>
Date: Sun, 01 Apr 2001 01:01:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <OF791BBBC5.E3FCBEEE-ON87256A18.005BA3B7@LocalDomain> you write:
>With ioctl, I can easily match a response of any kind to a request.  I can 
>even return an English text message if I want to be friendly.

But ioctl requires allocation of numbers.  Ugly and hard to scale.

Alex Viro's idea is cleaner, but still requires a fair amount of
coding even for simple interfaces.

Why not have a kernel thread and use standard RPC techniques like
sockets?  Then you'd not have to invent anything unimportant like
Yet Another IPC Technique.
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
