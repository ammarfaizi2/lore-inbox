Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWJYVtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWJYVtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWJYVtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:49:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:24771 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751028AbWJYVta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:49:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cOnlddbKrdp8cz+45L4Uylhdzrd/2mWy+1777T5nB+p8hT5JFHMbVJpxS14+0NT7G0j4rRYswzQ175Y0RKc8XUAWLBmNh1oVe+Vq1B5deb+P1ELlbRJLexu1VPHMsG1rWCTQZCiLcD+UWkSbW16azAeke9gM7UpnSTsSbZB89jI=
Message-ID: <b1bc6a000610251449j34e5226crc606a1759b6aca19@mail.gmail.com>
Date: Wed, 25 Oct 2006 14:49:28 -0700
From: "adam radford" <aradford@gmail.com>
To: "James Bottomley" <James.Bottomley@steeleye.com>
Subject: Re: [GIT PATCH] SCSI fixes for 2.6.19-rc3
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <1161792760.3816.6.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161792760.3816.6.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/06, James Bottomley <James.Bottomley@steeleye.com> wrote:
>  drivers/scsi/3w-9xxx.c                 |    5

James,

I NACK'd this patch in an earlier email and CC'd you on it:

"ioremap-balanced-with-iounmap-drivers-scsi-3w-9xxxc.patch"

Reason for NACK:  Whoever sprinkled iounmap() calls through various drivers put
                             this one in the wrong place, where
register accesses will occur
                             afterward while shutting down the card.

-Adam
