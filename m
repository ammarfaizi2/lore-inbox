Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWGKR6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWGKR6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWGKR6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:58:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:38379 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751080AbWGKR6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:58:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fKrj3XVwv+DLuYlbxIJ3F+tBdhNuG2uyIv4NvvPp3kXKMBtupL/BmzWmZ3fBWPiwHvcXaRhY1quWNnSr4bWT2s+icK67N+uydJF7gCylVJkqNMcxcDlIA2a5GmoIT4HuWWL8fzjdGmzNPu/HEDmmLREJUTT1ZcJUuk7PTgXOuT0=
Message-ID: <2c0942db0607111058s329c8af5sf514e6d2025cf4cf@mail.gmail.com>
Date: Tue, 11 Jul 2006 10:58:00 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [patch] i386: handle_BUG(): don't print garbage if debug info unavailable
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>,
       "Chuck Ebbert" <76306.1226@compuserve.com>,
       linux-kernel@vger.kernel.org, efault@gmx.de
In-Reply-To: <Pine.LNX.4.64.0607110959160.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607101034_MC3-1-C497-51F7@compuserve.com>
	 <20060711012755.59965932.akpm@osdl.org>
	 <44B382DD.5070202@yahoo.com.au>
	 <Pine.LNX.4.64.0607110959160.5623@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 11 Jul 2006, Nick Piggin wrote:
> >
> > OK but you don't need a do/while(0) here.
>
> Actually, the way Andrew wrote it, it _is_ needed. It does two things:
>
>  - it's the block scope that allows the private variables
>  - if the "get_user()" fails, the "break" means that you don't have to
>    have a goto.

<pedantry> The latter is true, but the former can also be done with
just bare braces:

  int a=4;
  {   int a=3;  printf("%d ",a); /* 3 */  }
  printf("%d ",a); /* 4 */

</pedantry, only useful to those who wish to write ugly code or source
code parsers>

Not being a person with actual *useful* skills, I can't comment on the
__get_user() issue :-).

Ray
