Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWGDTfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWGDTfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWGDTfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:35:19 -0400
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:46212 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S932336AbWGDTfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:35:18 -0400
Message-ID: <44AAC436.5040308@wolfmountaingroup.com>
Date: Tue, 04 Jul 2006 13:40:38 -0600
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Diego Calleja <diegocg@gmail.com>,
       arjan@infradead.org, zdzichu@irc.pl, helgehaf@aitel.hist.no,
       sithglan@stud.uni-erlangen.de, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>  <20060701170729.GB8763@irc.pl>  <20060701174716.GC24570@cip.informatik.uni-erlangen.de>  <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>  <20060703205523.GA17122@irc.pl>  <1151960503.3108.55.camel@laptopd505.fenrus.org>  <44A9904F.7060207@wolfmountaingroup.com>  <20060703232547.2d54ab9b.diegocg@gmail.com> <1151965033.16528.28.camel@localhost.localdomain> <Pine.LNX.4.61.0607041643470.4190@yvahk01.tjqt.qr> <44AA98B5.5060400@wolfmountaingroup.com> <44AAB8E8.3040405@garzik.org>
In-Reply-To: <44AAB8E8.3040405@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Jeffrey V. Merkey wrote:
>
>> The old novell model is simple. When someone unlinks a file, don't 
>> delete it, just mv it to another special directory called 
>> DELETED.SAV. Then setup the
>> fs space allocation to reuse these files when the drive fills up by 
>> oldest files first. It's very simple. Then you have a salvagable file 
>> system.
>
>
> Such a scheme makes it much more difficult to allocate large, 
> contiguous runs of free space for storing newly written data. 
>
>     Jeff


Possibly.  Organize the files in DELETED.SAV by disk location and 
date.     Files don't have to adhere to a strict date recycling 
process.  Make it a mount
option if the user wants strict date recycling.  Make the default to 
choose between date and file sector locality.

Jeff

>
>
>

