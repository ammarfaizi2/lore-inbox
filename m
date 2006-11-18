Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754368AbWKRKkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbWKRKkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756284AbWKRKkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:40:04 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:62725 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP
	id S1755982AbWKRKj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:39:59 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
References: <20061118010946.GB31268@vanheusden.com> <20061118020200.GC31268@vanheusden.com> <20061118020413.GD31268@vanheusden.com> <20061118023832.GG13827@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
Date: 18 Nov 2006 10:39:56 GMT
Message-ID: <455ee2fb$0$338$e4fe514c@news.xs4all.nl>
X-Trace: 1163846396 news.xs4all.nl 338 [::ffff:194.109.0.112]:60727
X-Complaints-To: abuse@xs4all.nl
In-Reply-To: <20061118023832.GG13827@flower.upol.cz>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20061118023832.GG13827@flower.upol.cz>,
Oleg Verych  <olecom@flower.upol.cz> wrote:
>On Sat, Nov 18, 2006 at 03:04:13AM +0100, Folkert van Heusden wrote:
>> > > > I found that sometimes processes disappear on some heavily used system
>> > > > of mine without any logging. So I've written a patch against 2.6.18.2
>> > > > which emits logging when a process emits a fatal signal.
>> > > Why not to patch default signal handlers in glibc, to have not only
>> > > stderr, but syslog, or /dev/kmsg copy of fatal messages?
>> > Afaik when a proces gets shot because of a segfault, also the libraries
>> > it used are shot so to say. iirc some of the more fatal signals are
>> > handled directly by the kernel.
>
>Kernel sends signals, no doubt.
>
>Then, who you think prints that "Killed" or "Segmentation fault"
>messages in *stderr*?
>[Hint: libc's default signal handler (man 2 signal).]

There is no such thing as a "libc default signal handler".
[Hint: waitpid (man 2 waitpid).]

Mike.
