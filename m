Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTDHEy3 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 00:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTDHEy2 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 00:54:28 -0400
Received: from almesberger.net ([63.105.73.239]:42503 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263937AbTDHEy2 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 00:54:28 -0400
Date: Tue, 8 Apr 2003 02:06:00 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030408020600.E19288@almesberger.net>
References: <20030407165009.13596.qmail@email.com> <20030407154303.C19288@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407154303.C19288@almesberger.net>; from wa@almesberger.net on Mon, Apr 07, 2003 at 03:43:03PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Example: I write some kind of RAID mounted at /world, that contains
> my disk under /world/disk, and some Flash storage under /world/flash.
> I protect /world/flash against writes by other people. If a
> read-only FD could be turned into something writeable, some malicious
> creature could "wear out" my Flash by writing to it a lot of times.

Just to clarify: the file in question would be inaccessible for the
abuser, and the read-only fd would have to be handed out by some
access mediator.

Obviously, if the abuser obtains a read-only fd directly by opening
a file, the hypothetical flink couldn't be used for privilege
escalation.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
