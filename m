Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWAEPQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWAEPQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWAEPQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:16:00 -0500
Received: from triton.atia.com ([193.16.246.115]:64541 "EHLO triton.atia.com")
	by vger.kernel.org with ESMTP id S1751400AbWAEPP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:15:59 -0500
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: sched.c:659 dec_rt_tasks BUG with patch-2.6.15-rt1
 (realtime-preempt)
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
	<20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
	<87u0cj5riq.fsf_-_@arnaudov.name>
	<1136436273.12468.113.camel@localhost.localdomain>
	<87u0cj3saf.fsf@arnaudov.name>
	<1136463552.12468.119.camel@localhost.localdomain>
	<87k6deg2z6.fsf@arnaudov.name>
	<Pine.LNX.4.58.0601050936340.10361@gandalf.stny.rr.com>
From: Nedko Arnaudov <nedko@arnaudov.name>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAM1BMVEX///8HBgUeFhGwUjwr
 NDF5RjOgVz2UVTxxTz9pNSXCiW2OUjhNIxi6bE6ROChWammgrK7+pa2IAAAAAXRSTlMAQObYZgAA
 AkxJREFUeAGtlAuTgyAMhK9gIGl4+P9/7W2wVbBo52YOZ2of+djdBPtT/7h+/lhf/wNYXFtLu38Y
 OCss7jEut4zMCTiXGzwiA7CMm78+XQPzemC9q15hun/7sovRAZcCg8QBfPRnF3QPd0jswHW9gUeK
 rwC2nwPTCRyudk9vhXtHXYgT4FxKOEn7zu83R+o3ULefUipKxjTn73LcPyzVbdck0YdAclJxE8C2
 hKHiM5ZKGm1NLFn9IyUNBoQzMZsDjCKxD89sl6dBYwJYCFgi/8TKGfWWYzPmDkfdM40nEgRSWIYE
 NREkQcdMem9SBzAStJJiCaxcpOAy4HDUARWbJyyRAKKwzbBoKQmAzBSqw/7iOJaYC+mTSYtiJs3d
 FFjggTkGKr54r6gPwRoMZboASonB+wJA2/wQ32tysfAU4MWr97kBuLdx4FNy5QKoCfVYprCdEAhE
 tFY7gb5LlcnqMwIgBASaI3S4S1AHoO7ASwH+bCTdFE4AmxP4wcIJMQFPaN01YBI5F7QT9wagq5KO
 FuHd/sS1b8VCUMTeofUV07gH4Cno1iuo2BQY079RqKSK49MWYcyBSOgWEMWk2iCsUV4RQW6BNopN
 wYJYBB7GcAqN2UXLbc3Cssyk9wpiw7NimwPqkemLArVZGBKIhWP8qkCExyaHHBn+Y4iR+rP3mQH1
 zKpMuDjmZ8DHfhDjpCsyYkUsxqsZy3EcxAgsDUCl/TnZYcJLgLVOogPWKkIB/rHzVm9QyGzE+mZ2
 YF1XHAQcPPy51kOhecI06vpCfgFqlF1IG9UTLgAAAABJRU5ErkJggg==
Date: Thu, 05 Jan 2006 17:15:12 +0200
In-Reply-To: <Pine.LNX.4.58.0601050936340.10361@gandalf.stny.rr.com> (Steven
 Rostedt's message of "Thu, 5 Jan 2006 09:39:37 -0500 (EST)")
Message-ID: <874q4ig0zj.fsf@arnaudov.name>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 5 Jan 2006, Nedko Arnaudov wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>>
>> > Although this should not bug, and I'm going to try this config on a UP
>> > machine myself to see if I can reproduce your problem, I'd suggest to
>> > you to turn off the SMP configuration.
>>
>> Unfortunatly this is not option for my setup, since I use same kernel on
>> multiple systems (kind of livecd but with usb disk). One of them is SMP
>> one. I'm currently doing audio only on one of machines and it is
>> uniprocessor one. I prefer to avoid triggerring this bug instead of
>> having multiple kernels.
>
> Understood.
>
> Does this bug on your SMP machines?
>
> Also where does it crash with cdrecord?  My UP test machine does not have
> a cd-burner. And I, unfortunately, don't have time now to put one in.

Will try to crash SMP ASAP, I'm not able to do tests now.

I do erase/burn of 210 MiB rw disk. Erase is done without crash.
I use version 2.01.01a03 of cdrecord.
It crashes when burning:

http://nedko.arnaudov.name/tmp/rt-cdrecord-crash.jpg

Same crash occurs when I run oss2jack with -d option.
It does not occur when running without -d option (daemonize).

=2D-=20
Nedko Arnaudov <GnuPG KeyID: DE1716B0>

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDvTgE6bb4v94XFrARAnjOAKCDxDjr36FidNUNxx1INefCTtGLJwCgiXNI
le9IejoKkbcvEK+adCr/3ww=
=ZF+G
-----END PGP SIGNATURE-----
--=-=-=--

