Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161696AbWKEU01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161696AbWKEU01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161704AbWKEU01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:26:27 -0500
Received: from terminus.zytor.com ([192.83.249.54]:21967 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161696AbWKEU00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:26:26 -0500
Message-ID: <454E48D9.3060303@zytor.com>
Date: Sun, 05 Nov 2006 12:26:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz> <AA4E0826-81F3-47AF-8C5E-D691BB02AB32@mac.com>
In-Reply-To: <AA4E0826-81F3-47AF-8C5E-D691BB02AB32@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Nov 04, 2006, at 18:38:11, Mikulas Patocka wrote:
>> But how will fdisk deal with it? Fdisk by default aligns partitions on 
>> 63-sector  boundary, so it will make all sectors misaligned and 
>> seriously kill performance even if filesystem uses proper 8-sector 
>> aligned accesses.
> 
> Don't use a partition-table format that dates back to drives with actual 
> reported physical geometry and which also maxed out at 2MB or so?  Even 
> the mac-format partition tables (which aren't that much newer) don't 
> care about physical drive geometry.
> 
> Besides, unless you're running DOS, Windows 95, or some random ancient 
> firmware that looks at your partition tables or whatever you can just 
> tell fdisk to ignore the 63-sector-alignment constraint and align your 
> partitions more efficiently anyways.  But if you're dealing with 
> hardware so new it supports 4k or 8k sectors, you really should be using 
> EFI or something.
> 
> Cheers,
> Kyle Moffett
> 

Actually, DOS/Win9x should handle arbitrary alignment just fine (except 
possibly some very very old versions of DOS which assumed that the first 
four sectors of IO.SYS all fell within the same track -- but I'm pretty 
sure that the FORMAT and SYS programs would align it for you.)

	-hpa
