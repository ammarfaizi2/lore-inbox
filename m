Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTH0Pkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTH0Pkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:40:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263484AbTH0Pkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:40:36 -0400
Date: Wed, 27 Aug 2003 11:40:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jason Baron <jbaron@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.22
In-Reply-To: <Pine.LNX.4.44.0308271127150.1491-100000@dhcp64-178.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0308271139380.697@chaos>
References: <Pine.LNX.4.44.0308271127150.1491-100000@dhcp64-178.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Jason Baron wrote:

>
> On Tue, 26 Aug 2003, Richard B. Johnson wrote:
>
> >
> > I configured, built and booted Linux-2.4.22. There are
> > some problems.
> >
> > (1) `dmesg` fails to read the first part of the buffered
> > kernel log. I have attached two files, dmesg-20 (normal)
>
> sounds like the log buffer wrapped around from a lot of printks
>

Perhaps the buffer size was changed??  I'll look at the printks()
I think there are the same number as before.

> > (3)  When umounting the root file-system, the machine usually
> > hangs. The result is a long `fsck` on the next boot. The problem
> > seems to be that sendmail doesn't get killed during the `init 0`
> > sequence. It remains with a file open and the root file-system isn't
> > unmounted. A temporary work-round is to `ifconfig eth0 down` before
> > starting shutdown. Otherwise, sendmail remains stuck in the 'D' state.
>
> this is likely the unshare_files change, which has been mentioned in
> several threads as causing similar type issues...i posted a patch that
> solves the issue, and Alan included a patch in his -ac series, which
> also addresses this issue.
>
> -Jason
>

Thanks, I'll check into it.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


