Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754642AbWKROJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbWKROJu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 09:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbWKROJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 09:09:50 -0500
Received: from main.gmane.org ([80.91.229.2]:6316 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1754642AbWKROJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 09:09:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
Date: Sat, 18 Nov 2006 14:09:37 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelu5ej.dd3.olecom@flower.upol.cz>
References: <20061118010946.GB31268@vanheusden.com> <20061118020200.GC31268@vanheusden.com> <20061118020413.GD31268@vanheusden.com> <20061118023832.GG13827@flower.upol.cz> <455ee2fb$0$338$e4fe514c@news.xs4all.nl>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice to meet you, Miquel!

On 2006-11-18, Miquel van Smoorenburg wrote:
> In article <20061118023832.GG13827@flower.upol.cz>,
> Oleg Verych  <olecom@flower.upol.cz> wrote:
>>On Sat, Nov 18, 2006 at 03:04:13AM +0100, Folkert van Heusden wrote:
>>> > > > I found that sometimes processes disappear on some heavily used system
>>> > > > of mine without any logging. So I've written a patch against 2.6.18.2
>>> > > > which emits logging when a process emits a fatal signal.
>>> > > Why not to patch default signal handlers in glibc, to have not only
>>> > > stderr, but syslog, or /dev/kmsg copy of fatal messages?
>>> > Afaik when a proces gets shot because of a segfault, also the libraries
>>> > it used are shot so to say. iirc some of the more fatal signals are
>>> > handled directly by the kernel.
>>
>>Kernel sends signals, no doubt.
>>
>>Then, who you think prints that "Killed" or "Segmentation fault"
>>messages in *stderr*?
>>[Hint: libc's default signal handler (man 2 signal).]
>
> There is no such thing as a "libc default signal handler".

By that i mean SIG_DFL, even if that means signal masks,
shell/debuger/tracer/lib/whatever installed *actual* functions.

Maybe there isn't one for actual patching (if someone really wants to
patch something ;). One may add, just like in libSegFault.so.
There are many in-userspace solutions, that problem isn't kernel's one.

> [Hint: waitpid (man 2 waitpid).]

Thanks.

--
-o--=O`C  info emacs : not found  /. .\ (is there any reason to live?)
 #oo'L O  info make  : not found      o (           R.I.P            )
<___=E M  man gcc    : not found    .-- (  Debian Operating System   )

