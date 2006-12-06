Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758509AbWLFAPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758509AbWLFAPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758599AbWLFAPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:15:14 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:19349 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758509AbWLFAPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:15:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=sRMn7m31Elo7f8cuEGKOhIr1+oLqsf0Hhnpc8PYurUP0gacYcB+alVVhG4byein5UvzKsjqBod2+4H140MUCnDf0Ho0OK6pWAH+ZNgq6yg+lgGbrh/fXxKr5pvunPBg830e6lGNbvYGl9ICv5fn5a4mvWrrzZfSY65CRn6zCPxg=
Message-ID: <45760B87.5050402@gmail.com>
Date: Wed, 06 Dec 2006 09:15:03 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ide-cd: Handle strange interrupt on the Intel ESB2
References: <20061204163057.2f27a12a@localhost.localdomain>	<58cb370e0612051523t2feba049rae830c9fa593b1c1@mail.gmail.com> <20061205235701.74b4c07b@localhost.localdomain>
In-Reply-To: <20061205235701.74b4c07b@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Wed, 6 Dec 2006 00:23:03 +0100
> "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:
> 
>> Looks good but aren't this trying to fix the same ICH
>> issue that is fixed in libata by ap->ops->irq_clear(ap)?
>>
>> [ please see Tejun's mail: http://lkml.org/lkml/2006/11/15/94 ]
>>
>> If so shouldn't we apply this fix for all ICH5/6/7/8 chipsets?
> 
> Possibly. Thats one reason I made it a quirk bit. I'd certainly expect it
> to be a group of related chipsets.
> 
>> Also shouldn't the fix be in IRQ handler?  Currently the fix is limited
>> to ide-cd driver which seems to be the wrong place as the problem
>> is supposed to happen also when using other IDE device drivers
>> or/and other ATA/ATAPI devices?
> 
> The problem has only be observed with CD devices doing PIO ATAPI
> commands. I am not aware of an Intel errata document that characterises
> this errata so anything else so cannot guess further. Perhaps Intel can
> advise ?

FWIW, on my ICH7, the IRQ storm does occur on ATA devices.

-- 
tejun
