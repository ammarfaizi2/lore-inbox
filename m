Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265067AbSJWQrQ>; Wed, 23 Oct 2002 12:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSJWQrP>; Wed, 23 Oct 2002 12:47:15 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:63934 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S265067AbSJWQrO>; Wed, 23 Oct 2002 12:47:14 -0400
Subject: Re: 2.4 Ready list - Kernel Hooks
To: Werner Almesberger <wa@almesberger.net>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF4A3346AB.B9CBFE3E-ON80256C5B.005B118D@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Wed, 23 Oct 2002 17:47:11 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 23/10/2002 17:53:22
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is the idea that people would deploy hooks locally, i.e. while
> profiling or debugging, or that some hooks would be put permanently
> in the kernel ?

Our principle reasons for using hooks is:

1) We simplify the integration of related facilities that would share a
number of common hook points, e.g. kdb, dprobes, ltt etc
2) We don't bloat the kernel with these feature but still have the ability
to turn them on dynamically when the need (or the pain) is sufficient for
us to do something about it.
2a) we can reduce the overhead of the extra function when dormant to almost
nil if it can be unhooked from the kernel.
3) We used them during development to extricate a function from the kernel
into a loadable module. This avoided many reboots and kernel builds.


>By the way, those hooks look like an excellent mechanism for
>circumventing the GPL, so you might want to export them with
>EXPORT_SYMBOL_GPL.

We already do that.

I don't envisage having an arbitrary set of hook points scattered
throughout the kernel. It's only when, for example, dprobes needed certain
hooks that we added them.



Richard

