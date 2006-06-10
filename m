Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWFJKHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWFJKHw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWFJKHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:07:52 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:27876 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751475AbWFJKHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:07:52 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Leubner, Achim" <Achim_Leubner@adaptec.com>
Subject: Re: HEADS UP for gdth driver users
Date: Sat, 10 Jun 2006 12:03:59 +0200
User-Agent: KMail/1.9.3
Cc: "Christoph Hellwig" <hch@lst.de>, linux-kernel@vger.kernel.org
References: <EF6AF37986D67948AD48624A3E5D93AFAA967C@mtce2k01.adaptec.com>
In-Reply-To: <EF6AF37986D67948AD48624A3E5D93AFAA967C@mtce2k01.adaptec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606101204.00742.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Achim,

Thanks for working on this!

On Friday, 9. June 2006 13:03, Leubner, Achim wrote:
> Attached you find a patch to remove the scsi_request interface from the
> gdth driver. The patch contains your first patch, the changes for
> removing the scsi_request interface and some changes to preserve the
> 2.4.x compatibility.
> We tested it and it should work fine. It would be great if it could be
> integrated in the 2.6.18 cycle.

Your driver also uses lots of kernel version dependent
code in the main driver file.

Please implement new kernel API functions using old kernel API
functions and put these into your existing gdth_kcompat.h file.

Rationale: Linux drivers are required to be forward compatible instead of
	backward compatible. More details per private email, if your needed.

Other issues with your patch were already raised by Andrew and Christoph.


Regards

Ingo Oeser
