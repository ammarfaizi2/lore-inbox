Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317822AbSFSJQO>; Wed, 19 Jun 2002 05:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317826AbSFSJQO>; Wed, 19 Jun 2002 05:16:14 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:44804 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S317822AbSFSJQN>; Wed, 19 Jun 2002 05:16:13 -0400
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: [PATCH]: (off 2.5.22) replacing __builtin_expect with unlikely in Alpha  headers
To: Manik Raina <manik@cisco.com>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: 
In-reply-to: <0C01A29FBAE24448A792F5C68F5EA47D29E3F6@nasdaq.ms.ensim.com>
Message-Id: <E17KbZA-00086H-00@pmenage-dt.ensim.com>
Date: Wed, 19 Jun 2002 02:15:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D29E3F6@nasdaq.ms.ensim.com>,
you write:
> 	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
> 	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
> #endif
>-	if (__builtin_expect(count, 0))
>+	if (unlikely(count, 0))
                          ^^^^ 

This should be

if (unlikely(count))

Paul

