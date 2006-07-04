Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWGDQ3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWGDQ3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWGDQ3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:29:43 -0400
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:39044 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S932272AbWGDQ3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:29:43 -0400
Message-ID: <44AA98B5.5060400@wolfmountaingroup.com>
Date: Tue, 04 Jul 2006 10:35:01 -0600
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Diego Calleja <diegocg@gmail.com>,
       arjan@infradead.org, zdzichu@irc.pl, helgehaf@aitel.hist.no,
       sithglan@stud.uni-erlangen.de, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>  <20060701170729.GB8763@irc.pl>  <20060701174716.GC24570@cip.informatik.uni-erlangen.de>  <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>  <20060703205523.GA17122@irc.pl>  <1151960503.3108.55.camel@laptopd505.fenrus.org>  <44A9904F.7060207@wolfmountaingroup.com>  <20060703232547.2d54ab9b.diegocg@gmail.com> <1151965033.16528.28.camel@localhost.localdomain> <Pine.LNX.4.61.0607041643470.4190@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607041643470.4190@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>There are some big problems with "deleted" however and doing it in
>>kernel space. A lot of programs just overwrite data. You would have to
>>look for things like O_TRUNC on a file open and ftruncate.
>>
>>    
>>
>At least I only want deleted files to be saved, not truncated. The way 
>the MSWIN (the gui parts) do it is enough for most users.
>
>
>Jan Engelhardt
>  
>
Well,

The old novell model is simple. When someone unlinks a file, don't 
delete it, just mv it to another special directory called DELETED.SAV. 
Then setup the
fs space allocation to reuse these files when the drive fills up by 
oldest files first. It's very simple. Then you have a salvagable file 
system.

Jeff
