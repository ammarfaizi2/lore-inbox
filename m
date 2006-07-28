Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161297AbWG1Uwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161297AbWG1Uwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbWG1Uwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:52:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:4846 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161297AbWG1Uwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:52:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XHrNepfuKk8wneq17vJplEziCuyofidyj9sWMM9NA7x5yQS2GRmmQJdsBlixlmItJs1UI0k2mPad80s3Vraj6K2U7JwcE5nNPd3NbQER3Q7V6uhQCISsKwtqRi1xytdvu5OMj4pgkaNduWecGtS/CtxyusM6IiuAIo4L8iKxEEk=
Message-ID: <41840b750607281352q715ad417l927f868aff306410@mail.gmail.com>
Date: Fri, 28 Jul 2006 23:52:28 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Cc: "Henrique de Moraes Holschuh" <hmh@debian.org>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Matt Domsch" <Matt_Domsch@dell.com>,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <200607281237.45576.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
	 <200607272127.14689.bjorn.helgaas@hp.com>
	 <20060728124940.GA26735@khazad-dum.debian.net>
	 <200607281237.45576.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> And there are no other devices that consume 0x1600-0x161F?  Interesting.
> I wonder what Windows does to bind drivers to the LPC devices?  Do they
> have to do the same SMBIOS OEM string hack?

We don't know. Maybe they check the ThinkPad part number (of which
there are many hundreds but IBM/Lenovo has the full list and can
update the driver whenever a new model comes out); or maybe just
assume you won't install it on the wrong hardware.


> I guess as long as they change the OEM string the same time they change
> the EC/accelerometer/battery/kitchen-sink implementation, you're OK :-)
> It just feels like living on borrowed time.

Yes. But it's the best we've been able to come up with, after
considerable community effort.

Anyway, this patch is independent of the ThinkPad case; DMI
information is there for drivers to see it, after all, so the kernel
should make it possible. Can I get a Signed-off-by?

  Shem
