Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267307AbUHMTOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267307AbUHMTOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUHMTN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:13:29 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:30440 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S266916AbUHMTJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:09:59 -0400
Date: Fri, 13 Aug 2004 21:09:58 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Torin Ford <code-monkey@qwest.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x Fork Problem?
Message-ID: <20040813190958.GB18563@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Jesse Pollard <jesse@cats-chateau.net>,
	Torin Ford <code-monkey@qwest.net>, linux-kernel@vger.kernel.org
References: <006101c47fff$8feedac0$0200000a@torin> <04081209262700.19998@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04081209262700.19998@tabby>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 09:26:27AM -0500, Jesse Pollard wrote:
> On Wednesday 11 August 2004 19:01, Torin Ford wrote:
> >
> > pid = fork();
> > switch (pid)
> > {
> >    case -1:
> >       blah; /* big trouble */
> >       break;
> >    case 0: /* Child */
> >       exit(1);
> >       break;
> >    default: /* Parent */
> >       pid2 = waitpid(pid, &status, 0);
> >       if (pid2 == -1)
> >       {
> >          blah;  /* check out errno */
> >       }
> > }
> 
> Yup - the parent process executed waitpid before the child process finished 
> the setup. This can happen in a multi-cpu environment or even a single, if
> the scheduler puts the parent process higher than the child in the queue.

ugh! I can follow the rationale for SMP.

But wouldn't this kind of behavior actually break most real world programs?

-- 
Frank
