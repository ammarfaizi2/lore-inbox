Return-Path: <linux-kernel-owner+w=401wt.eu-S932990AbWLSWF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbWLSWF5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933036AbWLSWF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:05:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:11941 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990AbWLSWF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:05:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=El84LpwBwJXZEtsswgLhs0ZsfZ5UVEAsUZSls22GAUQjByjenqhK6TXMe6u7jC2feyJJGP8g3i2GfP3mNWP3eXiZi6z/vfjI0rVB1E+Fy0w/MvvvC5Jbn5AWcV8qeFct68HuB6UjZpxPEKOaaparmyg6yhVb/fXjAqH+PfHMwcA=
Message-ID: <8bd0f97a0612191405o5aa8c469o5a5f4d3df2018ba5@mail.gmail.com>
Date: Tue, 19 Dec 2006 17:05:54 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch] search a little harder for mkimage
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061219122135.8100b198.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8bd0f97a0612182120q30361eceq6219b509f8add29a@mail.gmail.com>
	 <20061219122135.8100b198.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Andrew Morton <akpm@osdl.org> wrote:
> > -MKIMAGE=$(type -path mkimage)
> > +MKIMAGE=$(type -path ${CROSS_COMPILE}mkimage)
>
> Do all bash versions support `type -path'?

i've just always used `type -p` myself ...

but, bash-2.05 supports it for sure and that was released back in 2001 ...

> Perhaps /usr/bin/which would be safer, dunno.

which can be tricky as it behaves a little differently on some
platforms and may not always even be installed ... OS X for example is
notorious for being a piece of crap ... `which asdfasdf` will echo the
error to stdout and exit with a status of 0 even though the test
obviously failed
-mike
