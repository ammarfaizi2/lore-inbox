Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUC2DOb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 22:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUC2DOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 22:14:31 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:20106 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262579AbUC2DOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 22:14:30 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 28 Mar 2004 19:14:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ulrich Drepper <drepper@redhat.com>
cc: "linux-kern >> Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: For the almost 4-year anniversary: O_CLOEXEC again
In-Reply-To: <40677D1B.9060801@redhat.com>
Message-ID: <Pine.LNX.4.44.0403281902190.12828-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Ulrich Drepper wrote:

> The proposed solution is simple and already implemented on some systems
> (QNX, BeOS, maybe more).  Beside the definition of O_CLOEXEC the
> untested patch below should be all that's needed.

What does prevent a fork() to hit you right before set_close_on_exec()?
Shouldn't we have an install-and-set?

(Personally I manually handle the fork child's code in my MT apps, when 
I'm going to exec untrusted apps. Manually here mean close all open fds > 2)



- Davide




