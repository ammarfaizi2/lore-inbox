Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbUKNJMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbUKNJMB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 04:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUKNJMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 04:12:01 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:52386 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261266AbUKNJKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 04:10:30 -0500
X-OB-Received: from unknown (205.158.62.182)
  by wfilter.us4.outblaze.com; 14 Nov 2004 09:10:29 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 14 Nov 2004 04:10:29 -0500
Subject: Re: broken gcc 3.x update ("3.4.3""fixed")
X-Originating-Ip: 172.141.114.41
X-Originating-Server: ws1-6.us4.outblaze.com
Message-Id: <20041114091029.4CBE81CE302@ws1-6.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick review:

Someone asked why the kernel included backward
compatibility code to accomodate older gcc
versions than (I presume) whatever is the
newest stable gcc release version.

I described an example where gcc-3.3.x and
gcc-3.4.0 (and 3.4.1) could not parse
string literal concatenation code that
the gcc preprocessor from gcc-2.95.3 parses
with no problem, simply as an example of why
some people may not be jumping to upgrade
their gcc version, whether they are upgrading
their kernels or not.

I did not post an example that reproduces
the bug, because this is not the gcc bug list.
(I did post a simplified, ad-hoc snippet
of the same basic structure as the code
that triggered the bug, merely to show that
it was in fact routine C that the gcc
preprocessor should parse correcty without fail
if it is really ready for production use.)

There are of course other reasons to drag
one's feet on a gcc upgrade, like
some backend code generators being ready
for prime-time and others (for other cpu
architectures) not ready in particular gcc
releases.

> 1) What the hell does glibc version have
> to preprocessor behaviour?

My guess would be nothing in this case,
but as I have only tested the code that
triggered the literal string concatenation
bug that I saw in gcc-3.x (up to gcc-3.4.1)
and that I no longer see in gcc-3.4.3 with
one glibc version so far, that is merely likely
rather than certain.

> 2) Could you post the code (as small as possible)
> that triggers whatever bug you are talking about?
> Not a "here's the fragment that gets miscompiled"
> but something that could be fed to gcc and actually
> reproduce the bug.

If the original application code that triggered
the bug in gcc-3.x no longer triggers it in gcc-3.4.3,
what would be the point? Even if you still want
to use gcc-3.3.4, for example (which has the bug),
you'd have to patch gcc yourself. If you posted it
to a gcc development list, the gcc maintainers
would be likely to tell you it is already fixed
in 3.4.3, "so use that".

(Plus I'd have to go back and rebuild and reinstall
one of the no-longer-installed broken gcc versions,
just to test a piece of code that reproduces the bug
without being an application fragment. I'd do it
if it were for a good cause, but I'm not convinced
that simply using gcc-3.4.3 and forgetting about the
string literal concatenation bug in earlier 3.x versions
is not the better choice here.)

I had not tested gcc-3.4.3 when replying
to the question in the original thread
(about why the kernel has compatibility code
for gcc versions older than the current stable
gcc release), and I didn't want to leave the
impression that the bug I described in that
reply to the original thread was still an
unfixed gcc 3.x bug, once I discovered that
it was fixed in gcc-3.4.3.

Are we clear?

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

