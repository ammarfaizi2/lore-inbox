Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWGRWMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWGRWMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWGRWMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:12:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:61578 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932253AbWGRWMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:12:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e0t18UxlvG/rPXPzgtEyrCNFTHqO9h8aXhfL75JIWRJIadaaGul423WxOPwsRkfKmbm6lXdlDGx6nehSIgw3+GXDlqKhHIT5l1C90aioEiOMEDnrhQ1ATpUjPIQ7FeFEtb5MKwSKpFPeLFg985TM1MIUu5OEO3PMJ7pnG+qKAYU=
Message-ID: <9a8748490607181512t11e9970eu1a7aa1ad1644ec54@mail.gmail.com>
Date: Wed, 19 Jul 2006 00:12:32 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: [patch] i386: show_registers(): try harder to print failing code
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andi Kleen" <ak@suse.de>
In-Reply-To: <200607181425_MC3-1-C556-424A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607181425_MC3-1-C556-424A@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> show_registers() tries to dump failing code starting 43 bytes
> before the offending instruction, but this address can be bad,
> for example in a device driver where the failing instruction is
> less than 43 bytes from the start of the driver's code.  When that
> happens, try to dump code starting at the failing instruction
> instead of printing no code at all.
>
Shouldn't the kernel be printing some info noting that this fallback
is in use then? Or will that be completely obvious and I'm just not
able to see that?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
