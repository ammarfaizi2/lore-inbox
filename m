Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRCVQZ0>; Thu, 22 Mar 2001 11:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132074AbRCVQZR>; Thu, 22 Mar 2001 11:25:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37351 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132072AbRCVQZG>;
	Thu, 22 Mar 2001 11:25:06 -0500
Message-ID: <3ABA2719.C09F835E@mandrakesoft.com>
Date: Thu, 22 Mar 2001 11:23:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eli Carter <eli.carter@inet.com>
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <200103220638.HAA16050@green.mif.pg.gda.pl> <3ABA00BB.A9C2DF1B@mandrakesoft.com> <3ABA0E89.D3D965B7@inet.com> <3ABA103A.CB07012D@mandrakesoft.com> <3ABA15F7.6155F0EE@inet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter wrote:
> Mmmm.... documentation.  Yummy.  ;)
> 
> When I submitted the original patch, someone wanted to add the ff's
> check as well... to reduce the number of people who make that
> suggestion, perhaps the comment should read:
> 
> + * Check that the Ethernet address (MAC) is not a multicast address or
> + * FF:FF:FF:FF:FF:FF (by checking addr[0]&1) and is not
> 00:00:00:00:00:00.
> + *
> 
> Does that make it clear that both cases are covered by the one test?

yeah

> Hmm... I used __inline__ because the other function in the same
> headerfile used it...  What is the difference between the two, and is
> one depricated now?  (And what about in 2.2.x?)

since kernel requires gcc, which supports plaine ole 'inline', we don't
need to use the longer form.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
