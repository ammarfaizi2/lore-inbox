Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289319AbSBEAoi>; Mon, 4 Feb 2002 19:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289323AbSBEAo2>; Mon, 4 Feb 2002 19:44:28 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:30902 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289319AbSBEAoW>; Mon, 4 Feb 2002 19:44:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: arjan@fenrus.demon.nl
Subject: Re: current->state after kmalloc
Date: Tue, 5 Feb 2002 01:43:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m16XtOG-000OVeC@amadeus.home.nl>
In-Reply-To: <m16XtOG-000OVeC@amadeus.home.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16Xthq-147i9wC@fwd04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 February 2002 01:23, arjan@fenrus.demon.nl wrote:
> In article <16Xt8Y-1SQ44eC@fwd04.sul.t-online.com> you wrote:
> > set_current_state(TASK_INTERRUPTIBLE);
> > kmalloc(sizeof(struct x), GFP_KERNEL);
> >
> > what is current->state after kmalloc ?
>
> undefined. If kmalloc slept and you survived (due to setting
> TASK_INTERRUPTIBLE that's not guaranteed)  then it'll most likely be
> TASK_RUNNING.
> If you depend on this your kernel code is broken in that has subtle
> dependencies on unspecified behavior and will break whenever kmalloc
> changes internal behavior.

Is it safe with GFP_ATOMIC ?

	Regards
		Oliver
