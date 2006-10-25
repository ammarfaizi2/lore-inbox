Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423165AbWJYKBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWJYKBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423175AbWJYKBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:01:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:58186 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423165AbWJYKBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:01:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lo2cZ/d+DKQUiqwGpxZILhXAniM02LKNRZNzuIoxYWYwW5/RtzsafCCVYW8AtU5YUBFbG+cG6GWyc6Vw9k2hXbfy7UVX1tO7HDZWZUqOXfXQ6MzuoUz0POdbRfTvr10E5e17y6HtWhpZCcoh1Qt2EEYen/c3DpaafVx6AHlxi9o=
Message-ID: <9a8748490610250301k6d10b168x37a4d667c4016601@mail.gmail.com>
Date: Wed, 25 Oct 2006 12:01:20 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: What about make mergeconfig ?
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <1161755164.22582.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161755164.22582.60.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Hi folks !
>
> I'm not good enough at make and friends to do that myself without
> spending a lot more time than I have at hand, but I figured it might be
> something doable in a blink for whoever knows Kconfig guts :)
>
> What about something like:
>
> make mergeconfig <path_to_file>
>
> That would merge all entries in the specified file with the
> current .config. By mergeing, that basically means that rule:
>
> N + N = N
> m + N = m
> Y + N = Y
> m + Y = Y
>
> (that is, we basically take for each entry max(.config, merge file)
>
> The idea here is that on archs like powerpc, we have the ability to
> build kernels that can boot several platforms. However, the defconfigs
> we ship (g5_defconfig, pseries_defconfig, maple_defconfig, cell... ) are
> tailored for one platform.
>
> Now, if (for testing typically) I want to build a kernel that boots (and
> has all the necessary drivers) for both a g5 and a cell, I need to start
> from one of the defconfigs (the g5 one) and basically add in manually
> all the bits necessary from the other one (the cell one).
>
> Thus it might be useful to have a mecanism to automate that...
>
Hmm, wouldn't you only have to build that config once and then in the
future just use "make oldconfig" to keep it up-to-date with newer
kernels ?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
