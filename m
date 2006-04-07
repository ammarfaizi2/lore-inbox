Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWDGTYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWDGTYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWDGTYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:24:23 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:23258 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964906AbWDGTYW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:24:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B0WcS2+Yx9NvZhmE41feJ88j+aQLzDokdw6UgcEYXZgV9m2bUiNraYM30ar7WUWLLoDqO93g4txyhamw7bTSAoGJShfDj+DZ5LZx8YSnw7uwB4gP4x3quWiB6r7jNYWmwgG/VQlLoTJxcO5BvFqoyZbAIF9LBFlM20DuJ4kN4AE=
Message-ID: <bda6d13a0604071224u7b7ada61l16059cd538a8ee7e@mail.gmail.com>
Date: Fri, 7 Apr 2006 12:24:21 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: wait4/waitpid/waitid oddness
In-Reply-To: <m1fykpmbw2.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
	 <m1acaxnt1x.fsf@ebiederm.dsl.xmission.com>
	 <bda6d13a0604071158x33080de3ya8016dde59c2d97f@mail.gmail.com>
	 <m1fykpmbw2.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So what I see current in wait4 is:
> > asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
> >                         int options, struct rusage __user *ru)
> > {
> >       long ret;
> >
> >       if (options & ~(WNOHANG|WUNTRACED|WCONTINUED|
> >                       __WNOTHREAD|__WCLONE|__WALL))
> >               return -EINVAL;
>
> So where are you seeing the check in 2.6.16.1?
>
> Eric
Stupid me. I read that w/o the tilde.
