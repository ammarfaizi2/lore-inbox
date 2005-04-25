Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVDYE3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVDYE3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 00:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVDYE3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 00:29:06 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:52699 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S262530AbVDYE3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 00:29:03 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: 2.6.12-rc3 fails to read partition table
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 25 Apr 2005 04:31:02 +0200
References: <3WVhg-283-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DPtNH-0002DI-4R@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau <hubert.tonneau@fullpliant.org> wrote:
> Hubert Tonneau wrote:

>> 2.6.11 and 2.6.11.7 work fine.
>> 2.6.12-rc1 2.6.12-rc2 and 2.6.12-rc3 fail to read partiton table on my
>> laptop, also 2.6.12-rc3 works fine on another box also running FullPliant.
> 
> I tracked down the trouble to the following patch.
> Partitions with type 0 are now ignored, and my hda1 single partition has been
> unwisely set so.
> The question might be: is it a good idea to introduce that extra constrain
> in the middle of a stable serie ?

It is needed to work around other problems. Partition type 0 is usurally
considered to be empty, and some systems depend on that behaviour.
-- 
"If you see a bomb technician running, follow him."
-U.S.A.F. Ammo Tech Sgt

