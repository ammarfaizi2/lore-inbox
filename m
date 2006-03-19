Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWCSKi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWCSKi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 05:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWCSKi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 05:38:56 -0500
Received: from main.gmane.org ([80.91.229.2]:8378 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750805AbWCSKi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 05:38:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 19 Mar 2006 12:38:38 +0200
Message-ID: <dvjcb4$as2$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org> <yw1xoe0368yj.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart10120833.eE1x0IZmPx"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.49.48
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10120833.eE1x0IZmPx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit

Måns Rullgård wrote:
> Hmm, mine crashed when I used the PCI card.  Using the onboard sound
> was fine.

Now it doesn't crash. :-0 That hang was with kernel 2.6.15, but I switeched
back to 2.6.13 as that is what suse provides and I played some music on
both cards and tried Skype on the onboard card (there was the hang) and it
was OK.

>>>> Can you tell me how can I find the real device ID for my chipset? It
>>>> *should* be the same one as the original writer of the patch wrote (he
>>>> also had an ASUS A8V Deluxe as I understood), but the experience tells
>>>> it is not.
>>> 
>>> lspci -n will list the PCI IDs in hex.
>>
>> Thanks.
> 
> Care to post the output?

Sure. I still don't know how to use those numbers in the quircks.c  (do I
need to create something like #define PCI_DEVICE_WHATEVER pciIDNumber ?).
# lspci -n
00:00.0 Class 0600: 1106:0282
00:00.1 Class 0600: 1106:1282
00:00.2 Class 0600: 1106:2282
00:00.3 Class 0600: 1106:3282
00:00.4 Class 0600: 1106:4282
00:00.7 Class 0600: 1106:7282
00:01.0 Class 0604: 1106:b188
00:07.0 Class 0c00: 1106:3044 (rev 80)
00:08.0 Class 0104: 105a:3373 (rev 02)
00:0a.0 Class 0200: 11ab:4320 (rev 13)
00:0c.0 Class 0401: 1102:0002 (rev 07)
00:0c.1 Class 0980: 1102:7002 (rev 07)
00:0e.0 Class 0400: 109e:0350 (rev 12)
00:0f.0 Class 0104: 1106:3149 (rev 80)
00:0f.1 Class 0101: 1106:0571 (rev 06)
00:10.0 Class 0c03: 1106:3038 (rev 81)
00:10.1 Class 0c03: 1106:3038 (rev 81)
00:10.4 Class 0c03: 1106:3104 (rev 86)
00:11.0 Class 0601: 1106:3227
00:11.5 Class 0401: 1106:3059 (rev 60)
00:11.6 Class 0780: 1106:3068 (rev 80)
00:18.0 Class 0600: 1022:1100
00:18.1 Class 0600: 1022:1101
00:18.2 Class 0600: 1022:1102
00:18.3 Class 0600: 1022:1103
01:00.0 Class 0300: 10de:0326 (rev a1)

The result of lspci -vvvn is attached.

Andras
-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org

--nextPart10120833.eE1x0IZmPx
Content-Type: application/x-bzip2; name="pcilist.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pcilist.bz2"

QlpoOTFBWSZTWc0WJ9UABoDfgHwwYG//9z/v/8o/7//wYAt++9AAAw28gFB1Aqh1qqIICgAcZMmj
EMTTAQMCaYIwTE000AGEGRU8KejSnqeTU9CGgNMgMg0GmgADQAxCRRtJkBiDIaaAGJkNMhoAAA4y
ZNGIYmmAgYE0wRgmJppoAMIFKiKniNNEYIyKem1JmU2TRMaJjQJjUDEBEoIQT0FNiAITR6mo9TZQ
8UMeqGh4p6nqPSd8vuYq3BbmBYMUsBhDCxKhFGCEF/M8esnE4kBxef5yHkAKlZPxPO0ycpFIwj12
VlAp5rCa1K1KkRJs54pSeGkEVPQ8RN/Dy2mnDzSbK6aaxKFqGWkR1a46Yt9v+uZMXZC8AyjwEfP5
Ok5o9Up5AzfJv1GZv0zGhNX2Hug9CnzfpEkBhD4cR7INQhgdqdmX22VDQV0rpyDTFcrJjlYKQpEk
yqJ0BPtApCMYkC9hx1YYYQRZBEkU+JriJHQh1li5wKFCBCMkbY0QqRCDVjVjqHnCojhQe+U48q1r
Xh33OOFCW+L5o6QDWBnFkgwhFUxAIAba0pKG2iNAhCBIyAyIl6sBTafJG5cn1L7TIecb2av0AN9l
ykjEhCRFuhT1gHNugrYAurdYq0/YbADx09u4wDEyNnNqLK2imRsHGythiQRkJEkCQkEl6FISEixg
GqwB90X0GFvslChGEKSkYQkDf3Q51/KEnnEKvjU6mo7Ca4SWMBtE7xpa6OIhZp7fb1jSMsaJpRyA
Ok6g9R61feARA5PREjGd3Zx+rKk6Zbtp6Ceg6EMn6IHTvPgaQPvEPHNC7+gH69h4TSLbuXefh4An
l0J8R704hmGabk9KeB6mWQvhOwO1GBFIkUiRTA5tO7vZvwphLMs3nbHbHU71wpbKWJLrepzjtHut
t46ueu/S9Ye8G9fjWOCM0eh+zneZzluS6idKXc8w9OIcwO53SdncTyU94usuqnjpp2BmPq+Xhft8
C+F9Ps+iixPJ6g42YTw8kySMBWyCQiQe85ReGhETEQD772DAGKv6AEcRDRlhT2TALwGN5IyAJTbV
ItFiwVKgLZXnJQkGh936hapod1tbNB9lBxqxogSI2mTx0p3UgNrUzoauwgF4lQJIw1CSYytSEK7T
SYSVDGJShrNbazFKwyvWtkc61AKlpLa62yG0CQKixBoYmVA5qyrwpovDEMqVGEzRvoJCQmBThHbc
zScMjijgRQ1U0FCDqaUP70tKhE3UUqSoBC4wJADGGFdCWsYwqjupcIcIaAizQUFpkkypR1lTRhbU
AFkKTGkSmioVL4DfTWU588bpiUMAh4Cjlk4bL7TRzGJh+01GPMtLm5DO15ZlNdWiYF1NgAcAKW1F
X3EDXs48/Ry26XaQH6bONNVlhFAmCDRUDUuCmp7ppTGtEQGLGK5Gm26EjXIAXmUE/eGZRVrsIATY
ozqCQimvVqwd2E24Vo46MORnu14l8QxeXLjy5WnHacd3EagaSHOOsrKBwZz79uFw31l754ZEwOXp
Xf0lg/gpooZVpJSHElJS1atJiD7Zwvb13ETwqW3ykht0ab3vZyEca+i9CS+NHQAY6ShlSgpmVRpl
gOkm/AlBtDOTCc+OzXON9M9Ap0vjuf1HfDkqw6rVm1HxKqewPAMarelyrViFy5Q+SjA1qXYGI873
Yf79DVaqvxaKWEtJOpS5FLYafexK4X12V/ixUaqYS+cNvsamtYS5vjD1Jah6gxH5GKwWBiYGKTqs
0v+JYovixzg9t22QdFLWxHzUsSn8qX0Bs80l9dz7tiWlk+6wpZtQ+zQwl1LN14uFLkDZoCn4jC9B
GiPjALIw973ff7DtUbmokhhjG0mVheW8zDTEXWBupaLdlmHt9gjRFcuwRp8lD6QWEB3Dm+g8/3Ds
UtwH74Eb8WxC7bLklg4oTsMmyl/nD07NTyUsRv2JZR5Q47AZbshmuJLCWhTCWJfweW4G9x0uOltv
2d1ml6f4SzS8FLHnPkXQlhaeuxUDn/lxDcuDbIUNFtPKIcKHhsUcLTLZCZEHGd7HFHpzs5fsxnD5
Htw3fqp7k/QPXd69CxaB4A7bO4fXyAHEAz6w7zMjiAPAUfVfkSfzzEdpzKXIVySvT4PQeYm7m6JT
PBbuzk/LRpi0oKd/ZGQkJ7kO8Nl0X8Dq/cIJpaI+HmNdtuh85o71LsesNjoTC9qXefgHYze/w0hK
jAiPJKRTVrh9bBdjYzuX3B0/yMHJZn4H4Lzreudw/fFFy8vRzZvzuv9dtXFjklZN7Z0viS8XEw04
LbLiu6p5OtP50v0uIPhS3SwlwDEbsaSZDaGUv/BilmwA4KHWKatneJsNAtird2n616Cv2dvUmgh1
fAKXrcTJ6IfPo7OsdhBHvaYhsANCjACtjvALPnANvAgchTa7A0uYpc6EepM955X0jUuI0HV3A8xE
gsIQCB5e3FpQ1g8CISBD8+4U2YqnmHQi4DcA1vI39DSlzeENT1XLnIfKl4uG4NiXaltDN1N6m4NH
nqb6j5rul06JeM3PGu6pjUMTlM0wFrLBiYX1ByhpayZzaZNbRYWCvbfmytq+50JcHnwOKt8rnxcY
b5Xhl432+F0G5iVkMmHMi8izYaQYS3Jd94aJ4pOun0va+AOSW/UOdLjSwp7nWl/W4S5EuRz1RDgI
9zSMfg94uwLgHNJAThVRoMVcslm++bNnf4RtDiVta9N9ednGzm7JXCXsPMK4Bxg4VFzcqt7XWmbw
JcaOyW6k9IYbVMUuI28jXc40d5ueyV5WbclyMGPmxmpcfilmlnplxWkt54+jWNQ14w4M6uOYjQJp
mcutNbbLZDYpbMY24z2lNxazvy1lmTVLNLYGxTXy8JayuOjWU73Rt3S+LWpsV08YbZTxUuaXhDmV
ycqNevVkNV8L3OcOxyq9LHDrky5kvfuqWKXUdND/4u5IpwoSGaLE+qA=
--nextPart10120833.eE1x0IZmPx--

