Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWGSI7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWGSI7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWGSI7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:59:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:37568 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932534AbWGSI7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:59:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PWAP7L1KFcrLnrhsSXoq/zqyGXyLZKaqrOYyJOl7cPa+0zmnXBnG3ga8VWLBR0bmOl2coYEbE59CP5CrUZSwRSia3VHDw/ogVaprMrhQ2jmYzt+zNQiJ8By2iCSyMZiiKlVuZJDoFWDlQh+9w9mkUdTrfkZEqRNEU4afgZqoqDg=
Message-ID: <9a8748490607190159nf753e05td06062dd21d4aac@mail.gmail.com>
Date: Wed, 19 Jul 2006 10:59:36 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: [patch] i386: show_registers(): try harder to print failing code
Cc: "Andi Kleen" <ak@suse.de>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200607182027_MC3-1-C55F-B4E8@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607182027_MC3-1-C55F-B4E8@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> In-Reply-To: <9a8748490607181512t11e9970eu1a7aa1ad1644ec54@mail.gmail.com>
>
> On Wed, 19 Jul 2006 00:12:32 +0200, Jesper Juhl wrote:
> >
> > > show_registers() tries to dump failing code starting 43 bytes
> > > before the offending instruction, but this address can be bad,
> > > for example in a device driver where the failing instruction is
> > > less than 43 bytes from the start of the driver's code.  When that
> > > happens, try to dump code starting at the failing instruction
> > > instead of printing no code at all.
> > >
> > Shouldn't the kernel be printing some info noting that this fallback
> > is in use then? Or will that be completely obvious and I'm just not
> > able to see that?
>
> The code byte at EIP is marked with '<>', so it's obvious:
>
> Code: <a1> 00 00 00 00 c7 04 24 05 30 b5 de 89 44 24 04 e8 f5 6f 5c e1 c9 31 c0 c3 00 00 00 00 00 00 00
>

Ahh, ok. I was not aware of that. Thank you for the info.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
