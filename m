Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUHKQor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUHKQor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUHKQoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:44:46 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:30726 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S268105AbUHKQnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:43:10 -0400
Message-ID: <411A4C9D.4040902@optonline.net>
Date: Wed, 11 Aug 2004 12:43:09 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SCSI midlayer power management
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net> <1092231462.2087.3.camel@mulgrave> <1092237664.19009.23.camel@localhost.localdomain> <1092241693.1590.1.camel@mulgrave>
In-Reply-To: <1092241693.1590.1.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2004-08-11 at 10:21, Alan Cox wrote:
> 
>>In addition we are not doing SCSI target so multi-initiator is ok.
>>One question James - what are the rules for power management with
>>SCSI when we provide termpwr to a shared bus ?

Well there are (at least) two reasons to do shared bus: IP over SCSI and 
cluster filesystems. At least for cluster filesystems I think the answer 
is "don't suspend your machine" for the foreseeable future - what 
happens if your machine goes to sleep while holding cluster FS locks, 
etc. I doubt any CFS vendors are going to bother to support this any 
time soon, since it's a HA/server feature and power management is really 
a desktop/laptop feature.
