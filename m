Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbRC0IQy>; Tue, 27 Mar 2001 03:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130831AbRC0IQo>; Tue, 27 Mar 2001 03:16:44 -0500
Received: from [209.250.53.73] ([209.250.53.73]:17412 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S130820AbRC0IQ2>; Tue, 27 Mar 2001 03:16:28 -0500
Date: Tue, 27 Mar 2001 02:19:53 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockups on 2.4.2
Message-ID: <20010327021953.A435@hapablap.dyn.dhs.org>
In-Reply-To: <20010326231627.A468@hapablap.dyn.dhs.org> <5683.985680305@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5683.985680305@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Mar 27, 2001 at 06:05:05PM +1000
X-Uptime: 2:02am  up 1 min,  1 user,  load average: 2.23, 0.65, 0.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 06:05:05PM +1000, Keith Owens wrote:
> On Mon, 26 Mar 2001 23:16:27 -0600, 
> Steven Walter <srwalter@yahoo.com> wrote:
> >This has happened twice, now, though I don't believe its completely
> >reproduceable.  What happens is an Oops, which drops me into kdb.  I've
> >been in X both times, however, which makes kdb rather useless.
> 
> Documentation/serial-console.txt
>

Unfortunately I don't have the money to go and buy a dumb-terminal, and
the nearest other computer is ~30 feet away.  I've actually looked into
writing code that allows to kernel to return to VGA-text mode for this
reason.

> >The thing I find most interesting about this is that only 4 lines of the
> >oops gets into the log.  4 lines, both times.  This time, those lines
> >were:
> >
> > printing eip:
> >c0112e1f
> >Oops: 0002
> >CPU:    0
> 
> That is a symptom of a broken klogd.  Always run klogd with the -x
> switch.  If that does not work, take a look at
> 
> ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/patch-sysklogd-1-3-31-ksymoops-1.gz
> 
> One day the sysklogd maintainers might just fix this bug, that bug fix
> is almost 2 years old.

I actually already run klogd with -x due to earlier threads on lkml, so
it can't be that /particular/ problem, but klog/syslog may still be to
blame.  I'm usually lucky to get anything in my log between "--MARK--"
then "klogd restart" related to the crash.

-- 
-Steven
Freedom is the freedom to say that two plus two equals four.
