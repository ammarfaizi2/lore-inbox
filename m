Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWEEGaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWEEGaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 02:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWEEGaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 02:30:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:51868 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751486AbWEEGaG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 02:30:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oUJs+5CHdkbcj6ToYi8o7s2tqAvo2V3wmi2nst8OTFuNC81psTi1WyqZlFzkSZuCpBjoZH8P1WTZNA4727oDYa8DPTpHG8JKDCVtwMOZMdeIQ6wshPlpO16VEkWAo8MMNd3r/wc9qQhJGtngWHHgxx7q9ql5rS4c+Wjtyz24co0=
Message-ID: <c0c067900605042330s2ebfea1fk8d218a5a826f67f9@mail.gmail.com>
Date: Fri, 5 May 2006 02:30:05 -0400
From: "Dan Merillat" <harik.attar@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: Kbuild + Cross compiling
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060505045529.GA17896@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
	 <20060505045529.GA17896@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> kbuild checks for any differences in the commandline alos - so a rebuild
> happens if you change options to gcc (think -O2 => -Os).
> If you experience that for example mm/slab.c is rebuild then try to
> do the following:
> cp mm/.slab.o.cmd foo
> make mm/
> diff -u foo mm/.slab.o.cmd
>
> If diff detects any difference then you know why and need to find out
> why there is a difference.

Nothing, even md5sums match.
2abfcbee132335ba8e1da120569abf67  .do_mounts.o.cmd
2abfcbee132335ba8e1da120569abf67  .do_mounts.o.cmd.1

but it gets rebuilt every time.
>
> Btw. what make version and what kernel version are you compiling?
> There was some inconsistency in kbuild that triggered with make 3.81-rc1
> and which will trigger with make 3.82-cvs also.
> This issue was only fixed lately - recall it was for 2.6.16

2.6.15, but make 3.80.  Is that the same problem?

I havn't developed on i386 lately so I don't know if it's only a
cross-compile issue.
