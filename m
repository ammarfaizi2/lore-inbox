Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWIYT4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWIYT4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 15:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWIYT4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 15:56:13 -0400
Received: from mail-gw3.adaptec.com ([216.52.22.36]:30675 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1750710AbWIYT4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 15:56:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] fix idiocy in asd_init_lseq_mdp()
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Date: Mon, 25 Sep 2006 15:56:11 -0400
Message-ID: <A121ABA5B472B74EB59076B8E3C8F01902555F9B@rtpe2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix idiocy in asd_init_lseq_mdp()
Thread-Index: Acbgyh4UU5t9jsRkSY+LEGlGlK1CowAERv5g
From: "Hammer, Jack" <Jack_Hammer@adaptec.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Al Viro" <viro@ftp.linux.org.uk>
Cc: "Luben Tuikov" <ltuikov@yahoo.com>, <dougg@torque.net>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

asd_write_reg_dword() is the correct implementation for writing the
LmM0INTEN_MASK to the LmSEQ_INTEN_SAVE register.

Jack 



-----Original Message-----
From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
Sent: Monday, September 25, 2006 1:43 PM
To: Hammer, Jack; Al Viro
Cc: Luben Tuikov; dougg@torque.net; linux-scsi@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix idiocy in asd_init_lseq_mdp()

On Mon, 2006-09-25 at 18:39 +0100, Al Viro wrote:
> Far more interesting question: where does the hardware expect to see 
> the upper 16 bits of that 32bit value?  Which one it is -
> LmSEQ_INTEN_SAVE(lseq)
> ori LmSEQ_INTEN_SAVE(lseq) + 2?

I don't honestly know.  The change was made as part of a slew of changes
by Robert Tarte at Adaptec to make the driver run on Big Endian
platforms.  I've copied Jack Hammer who's now looking after it in the
hope that he can enlighten us.

James



