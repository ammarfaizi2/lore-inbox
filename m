Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUHYUGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUHYUGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUHYUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:06:42 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:52971 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S268406AbUHYUGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:06:10 -0400
Date: Wed, 25 Aug 2004 16:04:57 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
In-reply-to: <20040825120831.55a20c57.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, Brian Somers <Brian.Somers@Sun.COM>
Message-id: <412CF0E9.2010903@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
 <200408162049.FFF09413.8592816B@anet.ne.jp>
 <20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
 <20040825120831.55a20c57.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(removed Tetsuo from the as it appears the email address is stale)

David S. Miller wrote:
> On Wed, 25 Aug 2004 13:48:49 -0400
> Mike Waychison <Michael.Waychison@Sun.COM> wrote:
>
>
>>Tetsuo posted his lscpi -vv output and he has an A2.  The hardware
>>autoneg patch was written and tested against an A3.
>>
>>Would it make sense to do (hand-edited):
>
>
> Not really.  The autoneg code in the bcm5700 driver works on
> all revisions of the 5704 chipset.
>
> If I can't get this working soon, I'm disabling it for all boards.
> The software based fibre autoneg should work just fine for
> everyone.

If I understand it correctly, the problem we were seeing is that the
chip was getting framing errors in high-traffic scenarios.  Setting it
to use hardware autoneg made these errors disappear.  It's possible we
need some other work-around.. :\

Maybe Brian can better explain the issue at hand.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLPDodQs4kOxk3/MRAqrQAJkB0o0SFVv4rJiKcbT9b9LdcVcOowCfWljW
3cCak9CVYaY8Ecj+0s0Cd+M=
=V2EG
-----END PGP SIGNATURE-----
