Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTDJB1N (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 21:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTDJB1N (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 21:27:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28806 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263983AbTDJB1M (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 21:27:12 -0400
Date: Wed, 9 Apr 2003 21:43:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
In-Reply-To: <3E94A1B4.6020602@si.rr.com>
Message-ID: <Pine.LNX.4.53.0304092126130.992@chaos>
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org>
 <20030409080803.GC29167@mea-ext.zmailer.org> <20030409190700.H19288@almesberger.net>
 <3E94A1B4.6020602@si.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003, Frank Davis wrote:

> How about unifying the printk text messages into a limited set of
> common/canned text statements? If that could be done, all that would be
> needed in the kernel would be a small language translation table. The
> output of the table, based on the english input and the user's language
> setting, would be sent to the administrator/user.
>
> On a similar note, Andreas Dilger mentioned this suggestion earlier,
> which it seems has been echoed by others, and that might be agreeable...
[SNIPPED...]

> > Granted, you can have multi-level messages (like the VMS-style
> > %facility-severity-ident), but that only buys some time. And you
> > still either need a message catalog or include the plain text in
> > the message as well.
> >

No. VAX/VMS is dead. It got killed by things like that. Canned
strings that required valuable resources. You don't need any
of that. You need to use the kernel logging facility for the
three or four messages that a properly running system will
issue in its lifetime (like the file-system getting full).

There are too many damn strings in the kernel already. Making
them somehow legitimate is the wrong approach. If there are
so many error messages that we need a translation service, then
there are too many error messages, either because there are too
many errors, or because of the propensity of 'coders' (as opposed
to software engineers) to "print" every *%&$#@&#%_ thing that they
don't understand. Don't get me started, but when was it decided
that you should "print" everything that went okay? I saw during
the past month that somebody wanted to increase the size of
the kernel message ring buffer because they were losing
"important" data. They should fix the errors first before
making new errors. Then, you don't even need printk(). If
they are printing "good" stuff from the kernel, then the
kernel message facility is being abused.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

