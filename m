Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWHFGQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWHFGQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 02:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWHFGQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 02:16:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:5293 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932691AbWHFGQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 02:16:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fRp9d/lRw6pudJe7puR4tTI3QgdcjQPtWcIXgCosfLo8nEtvADvPJ3Iatb0xKnyG45QmO5TeujmGJVLEtJ9wO2X7B6nO6v/FOsdykAP6s+WRm3SdXsVs9frq1UAl8uWsgKB8KbdCBwt0bdCKJG1kqf47XkLcs//TBYukjqucwqU=
Message-ID: <6de39a910608052316x37ae7268j5ea18b6ea26219c5@mail.gmail.com>
Date: Sat, 5 Aug 2006 23:16:29 -0700
From: "Om N." <xhandle@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: writing portable code based on BITS_PER_LONG?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to port a driver written for IA32. This is a pci driver
and has a chipset doing PCI <-> local bus data transfer, where local
bus is 16 bit. So a number of values are converted by right/left
shifting by 16 bits.

Now that I am doing porting, I would like to make it fully portable
across AMD64 and IA32. What is the best method for this? Should I do
something like,

#if  BITS_PER_LONG = 64
shiftwidth = 48
#else if BITS_PER_LONG = 32
shiftwidth = 16
#endif

I don't like this. I would not do it if there is some elegant way.

Is there any other way?
