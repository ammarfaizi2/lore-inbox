Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUGGWyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUGGWyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUGGWyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:54:13 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:37028 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265649AbUGGWyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:54:07 -0400
References: <40EC13C5.2000101@kolivas.org> <40EC78A4.60304@sbcglobal.net>
Message-ID: <cone.1089240831.933520.4554.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: Re: 2.6.7-ck5
Date: Thu, 08 Jul 2004 08:53:51 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-4554-1089240831-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-4554-1089240831-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Wes Janzen writes:

> Hi Con,
> 
> I'm running ck4 and I'm getting pauses during init (alsa, hdparm, 
> hotplug).  By repeatedly pressing Alt-SysRq-p, I can get things going 
> again within 15 seconds, otherwise I suspect it would take that 3 1/2 
> hours to finish init like it did with ck3.  I think I had the same thing 
> just happen in X.  The mouse got jerky and then stopped responding, even 
> numlock wouldn't respond for about 15-30 seconds.  I'm logging a vmstat 
> now to see if I can reproduce it.

The suspect patch would be bootsplash.

> It seems that disabling kernel preemption solved the problem during 
> init, but the system feels slower (jerky mouse under X during compile).

It's extremely unlikely that the system would actually feel faster with 
preemption on in -ck so I suspect a touch of placebo effect.

> Would anything that you've updated since ck4 take care of this?  If not, 
> is there anything you can suggest I do to troubleshoot this issue?

Possibly the updated bootsplash patch might help. Another user had 
instability which was tracked down to bootsplash. The staircase scheduler is 
virtually unchanged so if it is responsible (which I'd like to think isn't 
the case) then the problem will not go away.

Suggestions (in order of likelihood):
-Update to -ck5
-Disable bootsplash
-Reverse patch bootsplash
-Don't enable any funky config options like regparm, 4k stacks or different 
Hz
-Start backing out patches one by one from the last to the first till it 
goes away.

Keep us informed if you find the culprit please.

> Thanks,
> 
> Wes

Cheers,
Con

--=_mimegpg-pc.kolivas.org-4554-1089240831-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7H7/ZUg7+tp6mRURApAfAKCDwM2i4wIyTvpYbjcoxQE63WAyhgCeIPnQ
00h8QEqKzUhqvkOL2TD9o6Y=
=EAbN
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-4554-1089240831-0001--
