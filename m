Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSHBRyK>; Fri, 2 Aug 2002 13:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSHBRyK>; Fri, 2 Aug 2002 13:54:10 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:43276 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315919AbSHBRyJ>; Fri, 2 Aug 2002 13:54:09 -0400
X-mailer: xrn 9.02
From: Paul Menage <pmenage@ensim.com>
Subject: Re: manipulating sigmask from filesystems and drivers
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, pmenage@ensim.com
X-Newsgroups: 
In-reply-to: <0C01A29FBAE24448A792F5C68F5EA47D2D3E2B@nasdaq.ms.ensim.com>
Message-Id: <E17agg9-0001vK-00@pmenage-dt.ensim.com>
Date: Fri, 02 Aug 2002 10:57:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D2D3E2B@nasdaq.ms.ensim.com>,
 you write:
>
>With write(), you have to make a judgement call. Unlike read, a truncated
>write _is_ visible outside the killed process. But exactly like read()
>there _are_ system management reasons why you may really need to kill
>writers. So the debatable point comes from whether you want to consider a
>killing signal to be "exceptional enough" to warrant the partial write.
>

How about a sysctl that lets the user specify the size threshold at
which writes use a killable wait state rather than
TASK_UNINTERRUPTIBLE? (Probably defaulting to never.)

Paul
