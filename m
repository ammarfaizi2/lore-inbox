Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWGGCmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWGGCmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 22:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWGGCmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 22:42:55 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:24967 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751150AbWGGCmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 22:42:55 -0400
Message-ID: <44ADCA0C.90401@emc.com>
Date: Thu, 06 Jul 2006 22:42:20 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>	 <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>	 <20060705214133.GA28487@fieldses.org>  <44AC7647.2080005@tmr.com> <1152189796.5689.17.camel@lade.trondhjem.org> <44ADC3CE.1030302@tmr.com>
In-Reply-To: <44ADC3CE.1030302@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.7.6.191432
X-PerlMx-Spam: Gauge=, SPAM=2%, Reason='EMC_FROM_0+ -2, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

> Trond Myklebust wrote:
>
>> Nobody gives a rats arse about backups: those are infrequent and
>> can/should use more sophisticated techniques such as checksumming.
>>
> Actually, those of us who do run production servers care vastly about 
> backups. And beside being utterly unscalable (checksum 20 TB of files 
> four times a day to find what changed???), you would have to remember 
> the checksums for all those files.
>
The point of using checksums (or digital signatures on files) is to be 
able to detect when the on disk file has been corrupted - not to look 
for updates.  With normal disks, even writes that are flagged as correct 
will occasionally actually end up corrupt on disk.  The rate that you 
need to validate the checksums is not at a 4 time a day rate.

Buying a nice, high array can make this much less of a concern, but 
those of us who get stuck using commodity disks should always have a way 
of detecting corruption and a backup (either on tape or on another box).

ric



