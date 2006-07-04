Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWGDGJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWGDGJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWGDGJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:09:30 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:23559 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932067AbWGDGJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:09:30 -0400
Message-ID: <44AA0612.10407@argo.co.il>
Date: Tue, 04 Jul 2006 09:09:22 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <17577.43190.724583.146845@cse.unsw.edu.au>
In-Reply-To: <17577.43190.724583.146845@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jul 2006 06:09:28.0367 (UTC) FILETIME=[684B9BF0:01C69F30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
>
> To my mind, the only thing you should put between the filesystem and
> the raw devices is RAID (real-raid - not raid0 or linear).
>
I believe that implementing RAID in the filesystem has many benefits too:
 - multiple RAID levels: store metadata in triple-mirror RAID 1, random 
write intensive data in RAID 1, bulk data in RAID 5/6
 - improved write throughput - since stripes can be variable size, any 
large enough write fills a whole stripe

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

