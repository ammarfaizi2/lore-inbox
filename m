Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264823AbSJOU6Z>; Tue, 15 Oct 2002 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264819AbSJOU5J>; Tue, 15 Oct 2002 16:57:09 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:1165 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264820AbSJOU44>; Tue, 15 Oct 2002 16:56:56 -0400
Message-Id: <5.1.0.14.2.20021015135529.051b49b0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Oct 2002 14:02:22 -0700
To: "David S. Miller" <davem@redhat.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [RFC] Rename _bh to _softirq
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20021015.131929.103080718.davem@redhat.com>
References: <5.1.0.14.2.20021015131839.01c1a008@mail1.qualcomm.com>
 <5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
 <20021015.124204.108190832.davem@redhat.com>
 <5.1.0.14.2.20021015131839.01c1a008@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:19 PM 10/15/2002 -0700, David S. Miller wrote:
>    From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
>    Date: Tue, 15 Oct 2002 13:23:28 -0700
>
>    _bh is not a "base handler" it stands for "bottom half".
>
>All of these phrases mean the same thing to me.
>
>Do you want to know what is different?  "tasklets",
>they are a totally different abstraction,
tasklets are softirqs. I mean they aren't much different. Tasklets are 
executed
from the softirq, so they have same context and stuff.

>as are "work queues"
Yep. These are different, because they are executed in process context.

>"base handler" and "bottom half" all refer to an execution
>context, and these days that means softirq.
I guess we should then have some kinda readme that explains what
all those things are. And the BH context covers softirqs and tasklets.

Max

