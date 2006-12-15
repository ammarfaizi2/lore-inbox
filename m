Return-Path: <linux-kernel-owner+w=401wt.eu-S1753036AbWLORg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbWLORg4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbWLORgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:36:55 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:41666 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753036AbWLORgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:36:55 -0500
Subject: Re: [patch 5/5] scsi: fix uaccess handling
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20061029213922.GA8494@osiris.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
	 <20061026130452.GF7127@osiris.boeblingen.de.ibm.com>
	 <20061028113143.GB14785@infradead.org>
	 <20061029213922.GA8494@osiris.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 11:36:37 -0600
Message-Id: <1166204197.2846.22.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 22:39 +0100, Heiko Carstens wrote:
> > While not your fault I'd suggest to fix the __put_user abuse at the same
> > time, as in the untested patch below for scsi_ioctl.c:
> 
> Makes sense. Even though the whole SCSI_IOCTL_GET_IDLUN ioctl interface
> is pretty pointless.
> It supports only up to 255 different ids and luns and might return the
> same 'dev_id' for two different devices...
> Any user space utility that depends on this interface would do the wrong
> thing (whatever that would be).

So has anyone actually tested this?

James


