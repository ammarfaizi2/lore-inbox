Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVCQJqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVCQJqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVCQJqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:46:19 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:35848 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S263030AbVCQJqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:46:17 -0500
Message-ID: <423951E3.6070804@tuxrocks.com>
Date: Thu, 17 Mar 2005 02:46:11 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] I8K driver facelift
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com> <4238A76A.3040408@tuxrocks.com> <200503170140.49328.dtor_core@ameritech.net>
In-Reply-To: <200503170140.49328.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
| Hrm, can we be a little more explicit and not poke in the sysfs guts right
| in the driver? What do you think about the patch below athat implements
| "attribute arrays"? And I am attaching cumulative i8k patch using these
| arrays so they can be tested.

Also, with power_status being a module parameter defaulting to 0/off, we
can leave out the device_create_file for the i8k_power_status_attr.  No
need to expose it in sysfs if it will always return -EIO.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCOVHjaI0dwg4A47wRAgquAJ49qf5qFZX9twSbLetJiliEnES5GwCg41z2
r6AWC22/zAcz54xAIfNQJ4I=
=0BtE
-----END PGP SIGNATURE-----
