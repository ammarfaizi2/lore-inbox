Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUHUMSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUHUMSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 08:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUHUMSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 08:18:08 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:18317 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S263100AbUHUMRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 08:17:55 -0400
Message-ID: <41273D6F.1030402@dgreaves.com>
Date: Sat, 21 Aug 2004 13:17:51 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, fsteiner-mail@bio.ifi.lmu.de,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>	 <4124BA10.6060602@bio.ifi.lmu.de>	 <1092925942.28353.5.camel@localhost.localdomain>	 <200408191800.56581.bzolnier@elka.pw.edu.pl>	 <4124D042.nail85A1E3BQ6@burner>	 <1092938348.28370.19.camel@localhost.localdomain>	 <4125FFA2.nail8LD61HFT4@burner>	 <101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>	 <4126F27B.9010107@dgreaves.com> <1093086364.7421.16.camel@nomade>
In-Reply-To: <1093086364.7421.16.camel@nomade>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:

>Le sam 21/08/2004 à 08:58, David Greaves a écrit :
>
>  
>
>>Can someone explain why it isn't anyone with _write_ access to the device?
>>Surely it's better to drop a user into a group or setgid a program?
>>
>>If I have write access to a device then I can wipe it's media anyway.
>>Is there something I'm missing?
>>    
>>
>
>If you have write access to a single partition only, you could always
>screw the entire disk (and with firmware upload, it's really totally
>screwed).
>
OK - I was thinking of the CD problem.

So only allow these operations on the whole disk device?

If you wanted to grant them this capability on a partition then my 
understanding is that through the power of these operations you've 
essentially given them the ability to overwrite to the whole device 
anway - so just give them write permission to the whole device. MNaybe 
through setgid code though.

If you need some operations to act on the partitions then you'd have to 
differentiate between users writing to a partition and users operating 
on the partition. Difficult without better acls - so then you have to 
say "operations on the whole disk device granted through write 
permission; operations on the partition devices forbidden"

The less reasons to make users use or suid root, the better.

David
