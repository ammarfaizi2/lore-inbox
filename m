Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVB1VnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVB1VnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVB1VnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:43:03 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:171 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261769AbVB1Vm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:42:59 -0500
Subject: Re: Signals/ Communication from kernel to user!
From: Lee Revell <rlrevell@joe-job.com>
To: Ravindra Nadgauda <rnadgauda@velankani.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <042701c51dab$561ef650$280e000a@blr.velankani.com>
References: <042701c51dab$561ef650$280e000a@blr.velankani.com>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 16:17:45 -0500
Message-Id: <1109625466.9273.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 21:06 +0530, Ravindra Nadgauda wrote:
> 
> Hello,
>    We wanted to establish a communication from kernel module (possibly a
> driver) to a user level process.
> 
>    Wanted to know whether signals can be used for this purpose OR there any
> other (better) methods of communication??

If you need fast IPC forget about signals.  They are way too slow.

The traditional UNIX way for userspace to talk to the kernel has been
ioctls.  For various reasons ioctls are not highly regarded in the Linux
kernel community.

I believe the currently favored method is to have the driver create
sysfs entries which userspace read()s and write()s.

Really, your question is too vague.  It would help if you said what
exactly you are trying to accomplish.

Lee

