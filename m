Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTKWCK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 21:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTKWCK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 21:10:26 -0500
Received: from main.gmane.org ([80.91.224.249]:55512 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263189AbTKWCKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 21:10:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Do I need kswapd if I don't have swap?
Date: Sun, 23 Nov 2003 03:10:21 +0100
Message-ID: <yw1xd6bjbzsi.fsf@kth.se>
References: <m3d6bj3lz6.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:AzrV69aMg3GSpH8A+Q741TSKexY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wuertele <dave-gnus@bfnet.com> writes:

> I expected this program to malloc most of my embedded MIPS's 32MB of
> system RAM, then eventually return with a -1 or a -2.  Unfortunately,
> it hangs having finally printed:
>
>   M26916864
>   W26916864
>   R26916864
>
> The malloc call isn't even returning.  What could explain that?

I can't help you there.

> I don't have swap space configured, and I notice several kernel
> threads that I figure might be assuming I have swap.  For example:
>
>       3 root     S    [ksoftirqd_CPU0]
>       4 root     S    [kswapd]
>       5 root     S    [bdflush]
>       6 root     S    [kupdated]
>       7 root     S    [mtdblockd]
>
> Do I need any of these if I don't have swap?  Are there any special
> kernel configs I should be doing if I don't have swap?

Swap space is really just special case of disk caching.  Many pages
will be backed by regular files, such as the text segment of most
processes.  Swap is used for pages that don't have a corresponding
disk file.  Not configuring any swap is perfectly normal, and
shouldn't cause any problems.  After all, swap is normally enabled by
some system boot script, so it has to be able to start without any
swap space.  For the record, I've been running without swap for a long
time on a system with enough real RAM.

-- 
Måns Rullgård
mru@kth.se

