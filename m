Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRC0IGO>; Tue, 27 Mar 2001 03:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130902AbRC0IGE>; Tue, 27 Mar 2001 03:06:04 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32895 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130873AbRC0IFy>; Tue, 27 Mar 2001 03:05:54 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Steven Walter <srwalter@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockups on 2.4.2 
In-Reply-To: Your message of "Mon, 26 Mar 2001 23:16:27 CST."
             <20010326231627.A468@hapablap.dyn.dhs.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Mar 2001 18:05:05 +1000
Message-ID: <5683.985680305@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001 23:16:27 -0600, 
Steven Walter <srwalter@yahoo.com> wrote:
>This has happened twice, now, though I don't believe its completely
>reproduceable.  What happens is an Oops, which drops me into kdb.  I've
>been in X both times, however, which makes kdb rather useless.

Documentation/serial-console.txt

>The thing I find most interesting about this is that only 4 lines of the
>oops gets into the log.  4 lines, both times.  This time, those lines
>were:
>
> printing eip:
>c0112e1f
>Oops: 0002
>CPU:    0

That is a symptom of a broken klogd.  Always run klogd with the -x
switch.  If that does not work, take a look at

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/patch-sysklogd-1-3-31-ksymoops-1.gz

One day the sysklogd maintainers might just fix this bug, that bug fix
is almost 2 years old.

