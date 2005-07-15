Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVGOMPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVGOMPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVGOMPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:15:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:26050 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261888AbVGOMPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:15:20 -0400
Date: Fri, 15 Jul 2005 14:15:16 +0200
From: Andi Kleen <ak@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@redhat.com>, Stephen Tweedie <sct@redhat.com>
Subject: Re: Inotify patch missed arch/x86_64/ia32/sys_ia32.c
Message-ID: <20050715141516.6c107c34@basil.nowhere.org>
In-Reply-To: <1121426860.1909.52.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1121426860.1909.52.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: Sylpheed-Claws 1.0.3 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005 12:27:40 +0100
"Stephen C. Tweedie" <sct@redhat.com> wrote:

> Hi,
> 
> The inotify patch just added a line
> 
> +				fsnotify_open(f->f_dentry);
> 
> to sys_open, but it missed the x86_64 compatibility sys32_open()
> equivalent in arch/x86_64/ia32/sys_ia32.c.

... and probably missing in the other compat layers too.
 
> Andi, perhaps it's time to factor out the guts of sys_open from the flag
> munging to keep as much of that code as common as possible, and avoid
> this sort of maintenance problem in the future?

No problem from my side if someone does a patch, but on the other hand if 
sys_open needs changes then likely all filp_open callers need too, and one would
better hope the patcher knows how to operate "grep -r" then. So it might
not buy much.

-Andi
