Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293095AbSCGOe2>; Thu, 7 Mar 2002 09:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292978AbSCGOeR>; Thu, 7 Mar 2002 09:34:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23294 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292955AbSCGOeM>;
	Thu, 7 Mar 2002 09:34:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>, rajancr@us.ibm.com
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Date: Thu, 7 Mar 2002 09:35:09 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com> <20020307145630.7d4aed95.rusty@rustcorp.com.au>
In-Reply-To: <20020307145630.7d4aed95.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020307143404.A8FFF3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 March 2002 10:56 pm, Rusty Russell wrote:
> On Mon, 4 Mar 2002 20:57:49 -0500
>
> Hubertus Franke <frankeh@watson.ibm.com> wrote:
> > Can somebody post why this patch shouldn't be picked up ?
> > The attached program shows the problem in user space
> > and the patch is almost trivial ..
>
> At a cursory glance, this seems to be three patches:
> 	1) Fix the get_pid() hang.
> 	2) Speed up get_pid().
>
> 	3) And this piece I'm not sure about:
> > +                 if(p->tgid > last_pid && next_safe > p->tgid)
> > +                       next_safe = p->tgid;
>
> Please split, and send the fix get_pid() hang to trivial patch monkey,
> and push optimization to Linus.
>
> Cheers!
> Rusty.

Thanks, patch was bad and not properly functioning as pointed out to us.
We are rewriting right now (actually <rajancr@us.ibm.com> 
is doing the coding. I am just there for idea bouncing
easy if the office is 2 doors away.

1) was done by Greg Larson and was already submitted
2) once properly done, we will circulate before bothering Linus again
3) this must have come in because of a wrong patch generation.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
