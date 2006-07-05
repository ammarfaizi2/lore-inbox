Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWGEMDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWGEMDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 08:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWGEMDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 08:03:40 -0400
Received: from mail.tmr.com ([64.65.253.246]:57229 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964834AbWGEMDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 08:03:39 -0400
Message-ID: <44ABAB2D.5050305@tmr.com>
Date: Wed, 05 Jul 2006 08:06:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <17577.43190.724583.146845@cse.unsw.edu.au> <44AA0612.10407@argo.co.il>
In-Reply-To: <44AA0612.10407@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Neil Brown wrote:
>>
>> To my mind, the only thing you should put between the filesystem and
>> the raw devices is RAID (real-raid - not raid0 or linear).
>>
> I believe that implementing RAID in the filesystem has many benefits too:
> - multiple RAID levels: store metadata in triple-mirror RAID 1, random 
> write intensive data in RAID 1, bulk data in RAID 5/6
> - improved write throughput - since stripes can be variable size, any 
> large enough write fills a whole stripe
> 
I rather like the idea of allowing metadata to be on another device in 
general, or at least the inodes. That way a very small chunk size can be 
used for the inodes, to spread head motion, while a larger chunk size is 
appropriate for data in some cases.

Larger max block sizes would be useful as well. Feel free to discuss the 
actual value of "larger."

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

