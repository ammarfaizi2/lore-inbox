Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275739AbRJUJBN>; Sun, 21 Oct 2001 05:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275734AbRJUJBD>; Sun, 21 Oct 2001 05:01:03 -0400
Received: from saga5.Stanford.EDU ([171.64.15.135]:27529 "EHLO
	saga5.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S275720AbRJUJAz>; Sun, 21 Oct 2001 05:00:55 -0400
Date: Sun, 21 Oct 2001 02:01:16 -0700 (PDT)
From: Ken Ashcraft <kash@stanford.edu>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] Probable Security Errors in 2.4.12-ac3
In-Reply-To: <002001c15a0a$41a0baf0$010411ac@local>
Message-ID: <Pine.GSO.4.33.0110210144380.865-100000@saga5.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's not a bug:
> * msgsz is limited to msg->m_ts (2 lines above store_msg)
> * msg->m_ts is set by sys_msgsnd to msgsz, and that function rejects messages longer than msg_ctlmax.

You're right.  The checker is broken there.  I should have noticed it.
Thanks for the note.

Ken

