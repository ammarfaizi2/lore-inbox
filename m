Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVAKSsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVAKSsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVAKSsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:48:08 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:44008 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261579AbVAKSsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 13:48:01 -0500
Date: Tue, 11 Jan 2005 19:47:53 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Laurent CARON <lcaron@apartia.fr>
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Unable to burn DVDs
In-Reply-To: <41E41B32.9070206@apartia.fr>
Message-ID: <Pine.LNX.4.60.0501111943500.8024@alpha.polcom.net>
References: <41E2F823.1070608@apartia.fr> <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr>
 <41E41B32.9070206@apartia.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Laurent CARON wrote:

> Jan Engelhardt wrote:
>
>>> Hello,
>>> 
>>> I recently upgraded to 2.6.10 and tried (today) to burn a dvd with 
>>> growisofs.
>>> 
>>> It seems there is a problem
>>> 
>>> Here is the output
>>> 
>>> 
>>> # growisofs -Z /dev/scd0 -R -J ~/foobar
>>> 
>>> 
>> 
>> I remember ide-scsi being broken now since you can use /dev/hdX directly 
>> for writing CDs.
>> 
>> 
>> 
> doesn't work for me
>
> growisofs -Z /dev/hdc -R -J ~/sendmail.mc
> :-( unable to open64("/dev/hdc",O_RDONLY): No such device or address

Do you have /dev/hdc?
Also if you have scsi emulation loaded it (IIRC) eats your normal device. 
Just try without it.

Also there is packet cdrw/dvd+-rw driver in kernel now (2.6.10?) that 
permits you to mount normal filesystem (for example UDF, but FAT or ISO - 
readonly of course or EXT2 or any other but better for your media without 
journal) on such device.


Grzegorz Kulewski

