Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281787AbSAARgN>; Tue, 1 Jan 2002 12:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbSAARgD>; Tue, 1 Jan 2002 12:36:03 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:43793 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S281787AbSAARfv>; Tue, 1 Jan 2002 12:35:51 -0500
Message-ID: <3C31F374.47A8424B@delusion.de>
Date: Tue, 01 Jan 2002 18:35:48 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: munmap return value
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

My manpage for munmap(2) says:
On success, munmap returns 0, on failure -1, and errno is set (probably to EINVAL).

In reality munmap always returns 0, except for when the address is
not page-aligned (-EINVAL) or if allocation of kernel structures
fails (-ENOMEM).

Shouldn't munmap return -EINVAL also if there is nothing mapped
at the specified address?

Regards,
Udo.
