Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVCRJWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVCRJWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVCRJWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:22:46 -0500
Received: from gandalf.light-speed.de ([82.165.28.152]:16040 "EHLO
	gandalf.light-speed.de") by vger.kernel.org with ESMTP
	id S261537AbVCRJWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:22:42 -0500
Message-ID: <423A9DD8.9080900@light-speed.de>
Date: Fri, 18 Mar 2005 10:22:32 +0100
From: Jens Langner <Jens.Langner@light-speed.de>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20050206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.4 1/1] fs: new filesystem implementation VXEXT1.0
References: <42399F54.1010108@light-speed.de> <20050317184601.GA15228@taniwha.stupidest.org>
In-Reply-To: <20050317184601.GA15228@taniwha.stupidest.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>>The VXEXT filesystem is more or less a FAT16 based filesystem which
>>was slightly modified by Wind River to allow the storage of more
>>than 2GB data on a partition, as well as storing filenames with a
>>maximum of 40 characters length.
> 
> Can this not then be folded into the existing vfat filesystem?

Sure it can. But I thought that as the VXEXT1.0 filesystem is per 
definition not a vfat filesystem it might be better to have it separated 
and not drill it into the IMHO anyway overly mixed up vfat/fat code 
already in the linux kernel tree. Even if that means that some parts in 
the code of the vxext filesystem are probably equal to the msdos 
implementation, please note that large parts which were not needed by 
the vxext implementation was dropped by me for clarifications.

So I still hope that my implementation is going to be considered for a 
future kernel tree integration as it may be quite usefull for embeeded 
systems wanting to access VxWorks partitions.

cheers,
jens
-- 
Jens Langner                                         Ph: +49-351-4716545
Lannerstrasse 1
01219 Dresden                                Jens.Langner@light-speed.de
Germany                                      http://www.jens-langner.de/
