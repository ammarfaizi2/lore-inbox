Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbULPNFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbULPNFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbULPND1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:03:27 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:11751 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262658AbULPM52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:57:28 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: how to detect a 32 bit process on 64 bit kernel
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 16 Dec 2004 14:00:16 +0100
References: <fa.fjvgjkq.i3u4a0@ifi.uio.no> <fa.hdf3d0t.iik609@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CevEu-0000UL-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin wrote:
> Quoting r. Brian Gerst (bgerst@didntduck.org) "Re: how to detect a 32 bit

>> The most portable way to do this is to have the first member of the
>> structure be a 32-bit value containing the size of the structure.

Better: Use version numbers.

> The size wont be sufficient here since its variable size 
> (ends with an array).

Use the size without the array, check the array size seperately.
Or see above.

> Sure, I could also just ask everyone to pass pointers in a
> packed long long, but either way it will break the applications.

If the size of structs you use in APIs is system dependant, it's most
likely b0rken.

> Why wouldnt it make sence for struct task to have a bit that tells
> me its a compat system?

Not having it will prevent you from creating strange interfaces.-)
