Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUENQGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUENQGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUENQGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:06:55 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:63684 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S261611AbUENQEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:04:36 -0400
Message-ID: <40A4EE3C.A80D4B5B@users.sourceforge.net>
Date: Fri, 14 May 2004 19:05:16 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens-dated-1085407799.3f43@endorphin.org>
Cc: Michal Ludvig <michal@logix.cz>, Andrew Morton <akpm@osdl.org>,
       jmorris@redhat.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
			<Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
			<40A37118.ED58E781@users.sourceforge.net>
			<20040513113028.085194a3.akpm@osdl.org>
			<40A3C639.4FD98046@users.sourceforge.net>
			<40A4CA28.4E575107@users.sourceforge.net> <20040514140958.GA8645@ghanima.endorphin.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:
> On Fri, May 14, 2004 at 04:31:20PM +0300, Jari Ruusu wrote:
> > cryptoloop and dm-crypt on-disk formats are FUBAR: precomputable ciphertexts
> > of known plaintext, and weak IV computation. Anything that claims
> > "cryptoloop compatible", and only that, is completely FUBAR. dm-crypt is
> > such. IOW, there are now _two_ backdoored device crypto implementations in
> > mainline.
> 
> Jari, you're starting to annoy me.

Hey, don't kill the messenger for bringing bad news.

loop-AES wasn't born perfect. But I have plead quilty for each and every
fuck-up that was there. And then went on and fixed the damn code.
Countermeasures against optimized dictionary attacks was included in 2001,
and stronger IV in 2003.

May I suggest that you do the same. Better late than never.

> You have been campaigning with FUD
> against cryptoloop/dm-crypt for too long now. There are NO exploitable
> security holes in neither dm-crypt nor cryptoloop.

In the past you, Fruhwirth, have demonstrated that you don't understand what
the security holes are. The fact that you still don't seem to undertand,
does not mean that the holes are not there.

> There is room for
> improving both IV deducation schemes, but it's a theoretic weakness, one
> which should be corrected nonetheless. However, modern ciphers are designed
> to resist known-plaintext attacks.

Optimized dictionary attack is exploitable. Ok, it requires major government
size funding, but what do you think NSA guys get paid for?

Watermark attack is exploitable using zero budget.

> The default setup of loop-aes' initrd is
> a greater threat to security, but wait for my paper on this.

I doubt it, but I'm waiting...

> In the meantime, stop spreading FUD,

You insisting that cryptoloop/dm-crypt do not have exploitable security
issues does not increase confidence at all. Quite the contrary, as it
implies that existing vulnerabilities won't be fixed.

>  especially stop abusing the term "backdoored"!

Initial crypto merge for mainline mount and losetup included support for
gpg-encrypted key files, and seeded+iterated key setup. This support was
merged to util-linux-2.12-WIP (work in progress). One cryptoloop developer
somehow managed to convince util-linux maintaner to drop those
countermeasures against optimized dictionary attacks. To protect the guilty,
I won't name his name here, but search linux-crypto archives for 14 Mar 2003
11:12:13 -0800 posting if you want know his name. Final util-linux-2.12 was
released with those countermeasures removed. In my opinion that was
deliberate implanting of exploitable vulnerability to mainline mount and
losetup. I call that backdoor. You call that whatever you want.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
