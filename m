Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030842AbWI0U61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030842AbWI0U61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030843AbWI0U60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:58:26 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:36372 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030842AbWI0U6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:58:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vgy1AvW4SHenADH1eC+mhBZNj716wGirNUPRdOJZxjPEQ1LbRbF6EFgOA1mVB100cOf+PYFYNuPZE1thkWAJUs5j92x4d9TK9NdemUP8FnFP9JApjJexJ1xVT+XeCZ0zh9BtiNec/JabVRAkkz2Xv+5U/f3c1U2bjRMI0hAy8LE=
Message-ID: <653402b90609271358m58950e96k99b2314f9732b5ef@mail.gmail.com>
Date: Wed, 27 Sep 2006 20:58:24 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2.6.18 real-V5] drivers: add lcd display support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060926120821.e11f3254.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060922220346.69f63338.maxextreme@gmail.com>
	 <20060926120821.e11f3254.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Andrew Morton <akpm@osdl.org> wrote:
> It's also probably-incorrect on big-endian CPUs.
> Perhaps you should not
> use bitops at all for this driver, use open-coded |
> and &/~ instead?

Uhm, someone told me that they shouldn't be used because the kernel
has generic functions for that.

I researched the kernel sources, and looking at bitops.h I found
setbit(), so I tried to use it in the driver, althought I prefer
standard |= and &=.

Are there more generic bitops kernel functions I may didn't find and I
should use in the future?

Anyway, it's just a question: I will turn back the driver to use |=
and &=, they look better to me too.
