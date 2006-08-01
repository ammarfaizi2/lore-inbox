Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWHAPZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWHAPZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWHAPZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:25:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:35668 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751679AbWHAPZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:25:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=PVu+tWDlFFAJBoRR2rsCpKLlHnIVskYLcP8lovYLEb56kunjQq+DmtugQI448CdqYGUILOekwtXTMJpWkKNcdPUxJsGsWxuUf2i1LiXfV4WvUjI30kUSqoGP2OM7KIB5JP5cArJ9PsKi3sjppMVJywzrinykOTt+i1sZwJShCik=
Date: Tue, 1 Aug 2006 17:25:03 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Amit Gud <agud@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] sysctl for the latecomers
Message-ID: <20060801152503.GA2825@slug>
References: <44CF69F0.6040801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF69F0.6040801@redhat.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 10:49:20AM -0400, Amit Gud wrote:
> /etc/sysctl.conf values are of no use to kernel modules that are inserted
> after init scripts call sysctl for the values in /etc/sysctl.conf
>
> For modules to use the values stored in the file /etc/sysctl.conf, sysctl
> kernel code can keep record of 'limited' values, for sysctl entries which
> haven't been registered yet. During registration, sysctl code can check
> against the stored values and call the appropriate strategy and proc_handler
> routines if a match is found.
>
> Attached patch does just that. This patch is NOT tested and is just to get
> opinions, if something like this is a right way of addressing this problem.
>
>
Hi,

One strange behaviour that comes to mind is the following:
1. I boot my machine so that it doesn't load module X
2. I modify /etc/sysctl.conf and I remove a line affecting module X
3. I modprobe X

Wouldn't the fact that the sysctl directive is applied anyway be a bit 
misleading?

Regards,
Frederik
