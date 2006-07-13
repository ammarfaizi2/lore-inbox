Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWGMGJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWGMGJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWGMGJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:09:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:20969 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932414AbWGMGJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:09:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bf4in9BhONR69CPuqxcoa84mSJgy+iUQ3MODZZ2KP+cLg2b595/jP/Sq8vuBJ/BvMj8oNDCIRvy1RajGsV+tjwHJA0ZVUU9yD8fvURwxHJhJrxXR774FecC6+DjqopGXsWZL0VnKgqK8FFHceRciqA1s7BUDpEJbk8PhpVwJ5m0=
Message-ID: <787b0d920607122309i364a3110re9907a947f907735@mail.gmail.com>
Date: Thu, 13 Jul 2006 02:09:50 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Cc: ak@suse.de, tytso@mit.edu, ebiederm@xmission.com, drepper@redhat.com,
       arjan@infradead.org, rdunlap@xenotime.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
In-Reply-To: <44B5DD41.90705@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
	 <44B5DD41.90705@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Albert Cahalan wrote:
> >>
> >> The numerical namespace for sysctl is unsalvagable imho. e.g.
> >> distributions regularly break it because there is no central
> >> repository of numbers so it's not very usable anyways in practice.
> >
> > Huh? How exactly is this different from system call numbers,
> > ioctl numbers, fcntl numbers, ptrace command numbers, and every
> > other part of the Linux ABI?
> >
>
> Mostly because some branches of the sysctl tree have dynamic content
> which is hard to marshal into a numeric form.

Dynamic content is no problem. FreeBSD uses sysctl
to implement their "ps" program. The process info comes
out of sysctl now. The sysctl man page has an example.

Non-numeric data is more troublesome. FreeBSD has
a syscall that will take text (still faster than /proc/sys),
and another that will convert the text representation
into numeric form for later high-performance use.

Look up all 3 calls here, in section 2:
http://www.freebsd.org/cgi/man.cgi?manpath=FreeBSD+7.0-current
