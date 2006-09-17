Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWIQOFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWIQOFg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 10:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWIQOFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 10:05:36 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:48525 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750989AbWIQOFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 10:05:35 -0400
Subject: Re: Linux 2.6.18-rc6
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Doug Ledford <dledford@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060917053815.GA10918@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
	 <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
	 <20060906110147.GA12101@aepfle.de>
	 <1157551480.3469.8.camel@mulgrave.il.steeleye.com>
	 <20060907091517.GA21728@aepfle.de>
	 <1157637874.3462.8.camel@mulgrave.il.steeleye.com>
	 <1158378424.2661.150.camel@fc6.xsintricity.com>
	 <20060917053815.GA10918@aepfle.de>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 09:05:09 -0500
Message-Id: <1158501909.3485.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 at 07:38 +0200, Olaf Hering wrote:
> As pointed out in private mail, this patch fixes the machine check for
> me. Thanks Doug.
> 
> Maybe the AHC_ULTRA2 feature check is needed as well for other cards.

It is ... the non ULTRA2 non twin cards might not have this register
(and if they do, it doesn't reflect the LVD/SE bus setting).

This is a pretty significant alteration, so it's not a -rc candidate,
but I'll put it in scsi-misc and see how it works out.

James


