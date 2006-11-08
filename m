Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161705AbWKHTKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161705AbWKHTKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161704AbWKHTKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:10:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:13842 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161694AbWKHTKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:10:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YF+uAk6sy+GNyqcYPBfV+mwzJfKASONETs7QjsSiqGgQQLEGcEDnBiyGSAPPHl8gMUgZkPgFlmYn24Q4yYOgK7cMQlx5j0Utc0C6ccQzkTlDU5KhFvyKJydTlfxrQcwKmfbXOs8s37pZu4qn8t4NfMeYhGr4M9k1F0Qd/3JUDLA=
Message-ID: <9a8748490611081110m4cc62c1bp3a36aba3fc314e56@mail.gmail.com>
Date: Wed, 8 Nov 2006 20:10:30 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
Cc: "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       alan@redhat.com, "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Jakub Jelinek" <jakub@redhat.com>, "Mike Galbraith" <efault@gmx.de>,
       "Albert Cahalan" <acahalan@gmail.com>,
       "Bill Nottingham" <notting@redhat.com>,
       "Marco Roeland" <marco.roeland@xs4all.nl>,
       "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
[...]
>
> Since the sys_sysctl implementation needs to stay around for a while
> and the worst of the maintenance issues that caused us to occasionally
> break the ABI have been addressed I don't see any advantage in
> continuing with the removal of sys_sysctl.
>
> So instead of merely increasing the deprecation period this patch
> removes the deprecation of sys_sysctl and modifies the kernel to
> compile the code in by default.
>
[...]
>
>  config SYSCTL_SYSCALL
>         bool "Sysctl syscall support" if EMBEDDED
> -       default n
> +       default y
>         select SYSCTL
>         ---help---
>           Enable the deprecated sysctl system call.  sys_sysctl uses

Perhaps you should also change the help text here to not say "the
deprecated sysctl system call". Perhaps change to something like :

"Deselect this option, to not build sysctl suport into the kernel, if
you are sure you won't be running any applications that depend on the
sysctl system call.
If unsure, say Y."

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
