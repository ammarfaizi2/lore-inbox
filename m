Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264987AbUFALdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbUFALdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUFALdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:33:04 -0400
Received: from gprs214-191.eurotel.cz ([160.218.214.191]:52609 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264987AbUFALbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:31:23 -0400
Date: Tue, 1 Jun 2004 13:31:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040601113113.GA16312@elf.ucw.cz>
References: <xb7aczqb2sv.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7aczqb2sv.fsf@savona.informatik.uni-freiburg.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>>> "Giuseppe" == Giuseppe Bilotta <bilotta78@hotpop.com> writes:
> 
>     Giuseppe> So, while we wait for complete support, at the kernel
>     Giuseppe> level, for all the multimedia keyboards supported by X,
>     Giuseppe> we *need* proper raw mode.
> 
> My question is: why do everything inside the kernel?
> 
> 
> Even  'khttpd' has  been removed  from  the kernel,  because the  same
> efficiency has been achieved in  the *userland* apache module.  Why is
> the input layer moving _backwards_?
> 
> I  don't think  converting  between keyboard/mouse  protocols and  the
> input   system's  "struct   input_event"  has   a   tighter  real-time
> requirement  than a  heavily loaded  web  server.  How  many keys  per
> second can  you type  at?  (Even  if you type  extremely fast  and the
> hardware constraints  (velocity, etc.) are  not reached yet,  there is
> still  a  limit that  the  keyboard  controller,  e.g.  i8042,  cannot
> exceed.)  How  many mouse movements are  you making per  second?  Is a
> userland driver unable  to handle that data rate?   (I don't think so.
> I believe enve a 386-DX 33MHz  can handle it with ease.)  If not, then
> please do it  in userland, so as not to waste  kernel memory (which is
> *NON-swappable*).

It would be nice to have keyboard in kernel because that means
keyboard works even on heavilly overloaded system, in case of oops
etc. (Unfortunately steps back were already taken; console switching
is no longer so robust w.r.t. kernel crashes :-( ).

Are you able to provide accurate timestamps for input events from
userland?
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
