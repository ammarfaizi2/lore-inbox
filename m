Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWBLMud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWBLMud (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 07:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWBLMud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 07:50:33 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:23463 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750716AbWBLMuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 07:50:32 -0500
In-Reply-To: <1139419590.27721.9.camel@localhost.localdomain>
References: <33D367D1-870E-46AE-A7EC-C938B51E816F@bootc.net> <1139400278.26270.10.camel@localhost.localdomain> <43E9F41C.30204@bootc.net>  <43EA11F5.4000205@bootc.net> <1139419590.27721.9.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7858A067-3711-456A-B601-1F2CB484E4F8@bootc.net>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: libata PATA status report on 2.6.16-rc1-mm5
Date: Sun, 12 Feb 2006 12:50:29 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Feb 2006, at 17:26, Alan Cox wrote:

> On Mer, 2006-02-08 at 15:44 +0000, Chris Boot wrote:
>> My next step will be to play with the CD drive. Any hints on
>> stress-testing the drive? Obviously writing a CD then comparing to  
>> the
>> ISO will be one step, but any others?
>
> The PATA specific code is almost entirely in the setup stages. Once  
> the
> setup is done then (with the exception of early PIIX devices, radisys,
> triflex and a couple of other oddities) there is no "new" code  
> actually
> being run.
>
> Alan
>

Well, I've just tried 2.6.16-rc2-ide2 on another VIA-based machine  
and it seems to work just fine, allowing me to say CONFIG_IDE=n :-)  
The CD drives work just fine including writing CDs, so I'm going to  
try writing a DVD soon, which should stress it a little more.  
However, I keep getting the following messages in dmesg:

[4294985.285000] Assertion failed! qc->n_elem > 0,drivers/scsi/libata- 
core.c,ata_fill_sg,line=2635
[4294985.377000] Assertion failed! qc->n_elem > 0,drivers/scsi/libata- 
core.c,ata_fill_sg,line=2635

This seems mostly harmless as everything seems to just work, but  
curious nonetheless.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

