Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272377AbTHNOXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 10:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272385AbTHNOXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 10:23:34 -0400
Received: from smtp2.BelWue.de ([129.143.2.15]:58023 "EHLO smtp2.BelWue.DE")
	by vger.kernel.org with ESMTP id S272377AbTHNOXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 10:23:31 -0400
Date: Thu, 14 Aug 2003 16:23:28 +0200 (CEST)
From: Oliver Tennert <tennert@science-computing.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 kbuild config logic and initrd
In-Reply-To: <Pine.LNX.4.44.0308141100280.12796-100000@picard.science-computing.de>
Message-ID: <Pine.LNX.4.44.0308141621540.16114-200000@picard.science-computing.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="662276-117648344-1060870966=:16114"
Content-ID: <Pine.LNX.4.44.0308141623170.16343@picard.science-computing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--662276-117648344-1060870966=:16114
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0308141623171.16343@picard.science-computing.de>

This is a patch remedying the problem stated below.



On Thu, 14 Aug 2003, Oliver Tennert wrote:

>
> Hello,
>
> While trying to use initrds with the 2.6.0-test3 kernel,
> I found out that ramdisk support (CONFIG_BLK_DEV_RAM) is allowed to be
> modular, while at the same time initrd support (CONFIG_BLK_DEV_INITRD) can be
> compiled into the kernel:
>
> CONFIG_BLK_DEV_RAM=m
> CONFIG_BLK_DEV_INITRD=y
>
> This does not make sense, however, as no initial ramdisk can be loaded
> while the generic ramdisk driver is outside the static kernel part!
>
> Consequently, I promptly fell for it, though I agree that it should have
> come to my mind before actually compiling the kernel!
>
> In 2.4 kernels, the configuration logic does not allow that.
>
>
> Regards
>
> Oliver
>
>
> --
> ________________________________________creating IT solutions
>
> Dr. Oliver Tennert			science + computing ag
> phone   +49(0)7071 9457-598		Hagellocher Weg 71-75
> fax     +49(0)7071 9457-411		D-72070 Tuebingen, Germany
> O.Tennert@science-computing.de		www.science-computing.de
>
>
>
>

--
________________________________________creating IT solutions

Dr. Oliver Tennert			science + computing ag
phone   +49(0)7071 9457-598		Hagellocher Weg 71-75
fax     +49(0)7071 9457-411		D-72070 Tuebingen, Germany
O.Tennert@science-computing.de		www.science-computing.de



--662276-117648344-1060870966=:16114
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="patch.initrd"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0308141622460.16114@picard.science-computing.de>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="patch.initrd"

LS0tIGRyaXZlcnMvYmxvY2svS2NvbmZpZy5vbGQJU2F0IEF1ZyAgOSAwNjoz
Mzo1MyAyMDAzDQorKysgZHJpdmVycy9ibG9jay9LY29uZmlnCVRodSBBdWcg
MTQgMTY6MjA6NDYgMjAwMw0KQEAgLTMzMSw2ICszMzEsNyBAQA0KIA0KIGNv
bmZpZyBCTEtfREVWX0lOSVRSRA0KIAlib29sICJJbml0aWFsIFJBTSBkaXNr
IChpbml0cmQpIHN1cHBvcnQiDQorCWRlcGVuZHMgb24gQkxLX0RFVl9SQU09
eQ0KIAloZWxwDQogCSAgVGhlIGluaXRpYWwgUkFNIGRpc2sgaXMgYSBSQU0g
ZGlzayB0aGF0IGlzIGxvYWRlZCBieSB0aGUgYm9vdCBsb2FkZXINCiAJICAo
bG9hZGxpbiBvciBsaWxvKSBhbmQgdGhhdCBpcyBtb3VudGVkIGFzIHJvb3Qg
YmVmb3JlIHRoZSBub3JtYWwgYm9vdA0K
--662276-117648344-1060870966=:16114--
