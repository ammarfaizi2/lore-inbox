Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136731AbREAVVz>; Tue, 1 May 2001 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136728AbREAVVg>; Tue, 1 May 2001 17:21:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5900 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135857AbREAVVV>; Tue, 1 May 2001 17:21:21 -0400
Subject: Re: Linux Cluster using shared scsi
To: Eric.Ayers@intec-telecom-systems.com
Date: Tue, 1 May 2001 22:24:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dledford@redhat.com (Doug Ledford),
        James.Bottomley@steeleye.com (James Bottomley),
        Chris.Roets@compaq.com (Roets Chris), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <15087.9645.153829.265882@gargle.gargle.HOWL> from "Eric Z. Ayers" at May 01, 2001 05:07:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uhdX-0002Pd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> reserved.    But if you did such a hot swap you would have "bigger
> fish to fry" in a HA application... I mean, none of your data would be
> there! 

	You need to realise this has happened and do the right thing. Since
	it could be an md raid array the hotswap is not fatal.

	If its fatal you need to realise promptly before you either damage
	the disk contents inserted in error (if possible) and so the HA
	system can take countermeasures


> if the kernel (by this I mean the scsi midlayer) was maintaining
> reservations, that there would be some logic activated to "handle"
> this problem, whether it be re-reserving the device, or the ability to

Suppose the cluster nodes don't agree on the reservation table ?

> Bus resets in the Linux drivers also tend to happen frequently when a
> disk is failing, which has tended to leave the system in a somewhat
> functional but often an unusable state, (but that's a different story...)

The new scsi EH code in 2.4 for the drivers that use it is a lot better. Real
problem.


