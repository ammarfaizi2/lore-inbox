Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263144AbREaSek>; Thu, 31 May 2001 14:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbREaSeb>; Thu, 31 May 2001 14:34:31 -0400
Received: from cnxt19932052.conexant.com ([199.191.32.52]:52752 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263144AbREaSeR>; Thu, 31 May 2001 14:34:17 -0400
Date: Thu, 31 May 2001 20:33:54 +0200 (CEST)
From: <rui.sousa@mindspeed.com>
X-X-Sender: <rsousa@localhost.localdomain>
To: David Raufeisen <david@fortyoz.org>
cc: <linux-kernel@vger.kernel.org>, <emu10k1-devel@opensource.creative.com>
Subject: Re: [Emu10k1-devel] Re:  how to crash 2.4.4 w/SBLive
In-Reply-To: <20010531105917.A10655@fortyoz.org>
Message-ID: <Pine.LNX.4.33.0105312031070.17958-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-560003691-991334034=:17958"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-560003691-991334034=:17958
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 31 May 2001, David Raufeisen wrote:

> Hi,
>
> I used this patch on 2.4.5, still oops's ..

But now it progressed a bit more ;)

>
> >>EIP; c01b91eb <sblive_writeptr_tag+2b/c0>   <=====
> Trace; c01bc853 <emu10k1_voice_free+43/80>
> Trace; c01b86c4 <emu10k1_waveout_close+24/40>
> Trace; c01b8666 <emu10k1_waveout_open+66/a0>
> Trace; c01b4f4f <emu10k1_audio_write+cf/1d0>
> Trace; c012cf46 <sys_write+96/d0>
> Trace; c0106bab <system_call+33/38>
>


New patch attached.

>
> On Thursday, 31 May 2001, at 12:01:05 (+0200),
> rui.sousa@mindspeed.com wrote:
>
> >
> > Thank you for the trace. Patch attached, please test it out.
> >
> > Rui Sousa
> >
> > P.S: in the future always CC emu10k1-devel, or instead of a 7 day delay in
> > getting something fixed the message might just get lost.
> >

--8323328-560003691-991334034=:17958
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0105312033540.17958@localhost.localdomain>
Content-Description: emu10k1 patch
Content-Disposition: attachment; filename=patch

ZGlmZiAtdSAtcjEuMTY2IGF1ZGlvLmMNCi0tLSBhdWRpby5jCTIwMDEvMDQv
MjIgMTU6NDQ6MjUJMS4xNjYNCisrKyBhdWRpby5jCTIwMDEvMDUvMzEgMTc6
MjM6MDMNCkBAIC0xMjMxLDYgKzEyMzEsOSBAQA0KIAkJd29pbnN0LT5idWZm
ZXIub3NzZnJhZ3NoaWZ0ID0gMDsNCiAJCXdvaW5zdC0+YnVmZmVyLm51bWZy
YWdzID0gMDsNCiAJCXdvaW5zdC0+ZGV2aWNlID0gKGNhcmQtPmF1ZGlvX2Rl
djEgPT0gbWlub3IpOw0KKwkJd29pbnN0LT50aW1lci5zdGF0ZSA9IFRJTUVS
X1NUQVRFX1VOSU5TVEFMTEVEOw0KKwkJd29pbnN0LT52b2ljZS51c2FnZSA9
IFZPSUNFX1VTQUdFX0ZSRUU7DQorCQl3b2luc3QtPmJ1ZmZlci5lbXVwYWdl
aW5kZXggPSAtMTsNCiANCiAJCWluaXRfd2FpdHF1ZXVlX2hlYWQoJndvaW5z
dC0+d2FpdF9xdWV1ZSk7DQogDQpJbmRleDogY2FyZHdvLmMNCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvdXNyL2xvY2FsL2N2c3Jvb3Qv
ZW11MTBrMS9jYXJkd28uYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTI5
DQpkaWZmIC11IC1yMS4xMjkgY2FyZHdvLmMNCi0tLSBjYXJkd28uYwkyMDAx
LzA1LzAyIDA3OjU4OjMxCTEuMTI5DQorKysgY2FyZHdvLmMJMjAwMS8wNS8z
MSAxNzoyMzowNA0KQEAgLTE0Myw4ICsxNDMsMTAgQEANCiAJaWYgKHdvaW5z
dC0+Zm9ybWF0LmJpdHNwZXJjaGFubmVsID09IDE2KQ0KIAkJdm9pY2UtPmZs
YWdzIHw9IFZPSUNFX0ZMQUdTXzE2QklUOw0KIA0KLQlpZiAoZW11MTBrMV92
b2ljZV9hbGxvYyhjYXJkLCB2b2ljZSkgPCAwKQ0KKwlpZiAoZW11MTBrMV92
b2ljZV9hbGxvYyhjYXJkLCB2b2ljZSkgPCAwKSB7DQorCQl2b2ljZS0+dXNh
Z2UgPSBWT0lDRV9VU0FHRV9GUkVFOw0KIAkJcmV0dXJuIC0xOw0KKwl9DQog
DQogCS8qIENhbGN1bGF0ZSBwaXRjaCAqLw0KIAl2b2ljZS0+aW5pdGlhbF9w
aXRjaCA9ICh1MTYpIChzclRvUGl0Y2god29pbnN0LT5mb3JtYXQuc2FtcGxp
bmdyYXRlKSA+PiA4KTsNCg==
--8323328-560003691-991334034=:17958--
