Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759094AbWK3I0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759094AbWK3I0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759092AbWK3I0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:26:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:41673 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759091AbWK3I0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:26:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m2akEab9cM0ORIMAqCGayF7HGUQbmRMmi3vuLf6gYo3QVM9gbkug0AiAHiKGINxETTb3xycqWNOT2ZdufqkLcdvHqjQ5WNKyqFqgX6odfVcoDNjWp6H+rIkhLcKTlLPRQ37rq6FYDCk1JWNSxvS/tCztuvNLyfmwldnps3/11Ic=
Message-ID: <b6fcc0a0611300026y6defe704o4f7dd4f1e82d5c1b@mail.gmail.com>
Date: Thu, 30 Nov 2006 11:26:04 +0300
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: just how "sanitized" are the sanitized headers?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611291812510.7515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611291812510.7515@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
>   i noticed that, when i generate the sanitized headers with "make
> headers_install", there are still a number of headers files that are
> installed with variations on "#ifdef __KERNEL__".
>
>   i always thought the fundamental property of sanitized headers was
> to be compatible with glibc

You were wrong.

> and have no traces of "KERNEL" content
> left.

That's correct.

> so what's the purpose of leaving some header files with that
> preprocessor content?

When you see __KERNEL__ in sanitized headers, it's either due to
a) unifdef bug, or
b) header being listed in header-y when it should be listed in unifdef-y
