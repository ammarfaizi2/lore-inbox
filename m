Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUGMAYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUGMAYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUGMAY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:24:26 -0400
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:9173 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264482AbUGMAWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:22:23 -0400
References: <20040712163141.31ef1ad6.akpm@osdl.org> <200407122358.i6CNwvBD003469@localhost.localdomain> <20040712170649.6f4c0c71.akpm@osdl.org>
Message-ID: <cone.1089678113.958014.12958.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Voluntary Kernel Preemption Patch
Date: Tue, 13 Jul 2004 10:21:53 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-12958-1089678113-0002";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-12958-1089678113-0002
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Andrew Morton writes:

> Paul Davis <paul@linuxaudiosystems.com> wrote:
>>
>> >resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
>> >fixes ended up breaking the fs in subtle ways and I eventually gave up.
>> 
>> andrew, this is really helpful. should we conclude that until some
>> announcement from reiser that they have addressed this, the reiserfs
>> should be avoided on low latency systems?
>> 
> 
> It seems that way, yes.  I do not know how common the holdoffs are in real
> life.  It would be interesting if there was a user report that switching
> from reiserfs to ext2/ext3 actually made a difference - this would tell us
> that it is indeed a real-world problem.
> 
> Note that this info because available because someone set
> /proc/asound/*/*/xrun_debug.  We need more people doing that

Can I just point out that the reiserfs3.6 delays that I originally reported 
with the preempt threshhold test did not come up once the patch was fixed. I 
have my preempt threshold set at 1ms and did not see one single reiserfs 
dump in my syslog. ie I don't think I am personally seeing any significant 
reiserfs3.6 latencies.

Cheers,
Con


--=_mimegpg-pc.kolivas.org-12958-1089678113-0002
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8yshZUg7+tp6mRURAloCAJ42Ql94R2EsxPaCWV2PUb3EJZwa1gCeMwzS
tRI5F6baZJMdMTPgWkuBolA=
=kNOL
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-12958-1089678113-0002--
