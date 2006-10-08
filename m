Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWJHWky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWJHWky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWJHWkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:40:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:15445 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751517AbWJHWkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:40:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nbzQmrhvZt+rmgJ7otfmDVY2j8vcHResB9zuQ2SS6bQjIGyV9Qwrx9O3f/ltbkHMUCOGrsHMFOma2oPUwjpO7MiIcDGerTGQeXNpd9WUr0t5lsaSbDJ1FZbArD1OXV4RfT6rajblzmht6jXcMlJNDfWRVrWo7qprNLMYgW3da0Q=
Message-ID: <9a8748490610081540t3d7dc7a3pce8cab496cd57340@mail.gmail.com>
Date: Mon, 9 Oct 2006 00:40:52 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "James Courtier-Dutton" <James@superbug.co.uk>
Subject: Re: 2.6.18-rt5 crashes with netconsole enabled. (bug#7288)
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>
In-Reply-To: <4529734B.7070707@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4529734B.7070707@superbug.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/06, James Courtier-Dutton <James@superbug.co.uk> wrote:
> Hi,
>
> Does anyone have any clues where I can find help regarding the rt kernels?
>

You could start by adding Ingo Molnar to Cc: (added)  since he's the
creator of the -rt kernels.


> Please see kernel bug entry:
> http://bugzilla.kernel.org/show_bug.cgi?id=7288
> Description: 2.6.18-rt5 crashes with netconsole enabled. (bug#7288)
>
> Full console trace attached to bug report.
> Extract of console trace of crash/hang:
>
> modprobe/8459[CPU#1]: BUG in write_msg at drivers/net/netconsole.c:85
> 5/0x67
>  [<c012274d>] _call_console_drivers+0x4e/0x52
>  [<c0122d92>] release_console_sem+0x12a/0x1dc
>  [<c0122ac7>] vprintk+0x299/0x2e1
>  [<c0122b24>] printk+0x15/0x17
>  [<f8991090>] init_netconsole+0x75/0x80 [netconsole]
>  [<c013dbec>] sys_init_module+0x1597/0x175d
>  [<c0102f99>] sysenter_past_esp+0x56/0x79
> modprobe/8459[CPU#1]: BUG in write_msg at drivers/net/netconsole.c:87
>  [<c0103f92>] show_trace+0x16/0x19
>  [<c0104583>] dump_stack+0x1a/0x1f
>  [<c01234aa>] __WARN_ON+0x41/0x57
>  [<f899112c>] write_msg+0x91/0xc9 [netconsole]
>  [<c01226ed>] __call_console_drivers+0x55/0x67
>  [<c012274d>] _call_console_drivers+0x4e/0x52
>  [<c0122d92>] release_console_sem+0x12a/0x1dc
>  [<c0122ac7>] vprintk+0x299/0x2e1
>  [<c0122b24>] printk+0x15/0x17
>  [<f8991090>] init_netconsole+0x75/0x80 [netconsole]
>  [<c013dbec>] sys_init_module+0x1597/0x175d
>  [<c0102f99>] sysenter_past_esp+0x56/0x79
> modprobe/8459[CPU#1]: BUG in write_msg at drivers/net/netconsole.c:85
>  [<c0103f92>] show_trace+0x16/0x19
>  [<c0104583>] dump_stack+0x1a/0x1f
>  [<c01234aa>] __WARN_ON+0x41/0x57
>  [<f8991102>] write_msg+0x67/0xc9 [netconsole]
>  [<c01226ed>] __call_console_drivers+0x55/0x67
>  [<c012274d>] _call_console_drivers+0x4e/0x52
> le+0x1597/0x175d
>  [<c0102f99>] sysenter_past_esp+0x56/0x79
> modprobe/8459[CPU#1]: BUG in write_msg at drivers/net/netconsole.c:87


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
