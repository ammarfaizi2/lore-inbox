Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbSKSSmN>; Tue, 19 Nov 2002 13:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSKSSlp>; Tue, 19 Nov 2002 13:41:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41732 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267161AbSKSSlK>;
	Tue, 19 Nov 2002 13:41:10 -0500
Message-ID: <3DDA8746.3010409@pobox.com>
Date: Tue, 19 Nov 2002 13:47:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: Douglas Gilbert <dougg@torque.net>,
       Andre Hedrick <andre@pyxtechnologies.com>,
       "J. E. J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.18-modified-scsi-h.patch
References: <Pine.LNX.4.10.10211182138310.2779-200000@master.linux-ide.org> <3DDA0E63.9050307@torque.net> <20021119104004.A21438@eng2.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.10.10211182138310.2779-200000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:

> I don't see why we need the #define, or is that another patch?



The define exists for the same reason that HAVE_xxx exists in 
include/linux/netdevice.h and other headers:  a feature test macro, so 
code using this pointer can detect its presence or absence.  The world 
of drivers is not all in the kernel tarball, ya know ;-)

But as I said, the macro is misnamed, it should be 
HAVE_UPPER_PRIVATE_DATA or similar.

	Jeff



