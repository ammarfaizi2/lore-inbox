Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422874AbWKFAgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbWKFAgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 19:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWKFAgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 19:36:52 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:12195 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1422874AbWKFAgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 19:36:51 -0500
Message-ID: <454E8379.1020100@keyaccess.nl>
Date: Mon, 06 Nov 2006 01:36:09 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Kyle Moffett <mrmacman_g4@mac.com>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz> <AA4E0826-81F3-47AF-8C5E-D691BB02AB32@mac.com> <454E48D9.3060303@zytor.com> <454E575B.40403@keyaccess.nl> <454E5CDC.7000002@zytor.com>
In-Reply-To: <454E5CDC.7000002@zytor.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Rene Herman wrote:

>> For primary (and extended) partitions, yes. I haven't used any version 
>> of DOS that has ever objected to arbitrarily aligned partitions in the 
>> MBR (and I do align them arbitrarily since I always make my partitions 
>> some exact size and start the next partition in the next sector).
>>
>> Different though for logical partitions inside an extended. As late as 
>> Windows 98, DOS would object to non-aligned logicals, at the very 
>> least with some settings for the BIOS use/don't use LBA or "Large" 
>> settings.
>>
>> Linux doesn't care; I've used type 0x85 instead of 0x05 for my 
>> extended partitions dus to that for years. DOS just ignores that one...
>>
> 
> DOS, or FDISK?

DOS. It was something like DOS accepting the non cylinder-aligned 
logical but then proceding as if it were cylinder aligned anyway, 
rounding the starting sector down. This obviously is not good.

Also see the "--DOS-extended" comment in the sfdisk man page. Since I do 
remember differences when using different "Large" CHSs in the BIOS, for 
all I remember I was experiencing that problem when I ran into it. If 
so, the DOS underlying Windows 98 is among the "some versions".

In any case, yes, non-cylinder aligned logical partitions (for whichever 
defintion of "aligned" fits DOS' idea of the geometry) really do cause 
trouble.

The DR-DOS (-> Novel DOS -> Caldera OpenDOS) warning in that manpage 
seems to imply that cylinder alignment was a good idea for all 
partitions seen by it, and I do remember it being a pain in that regard 
as well. Guess it's pretty safe to not care about DR-DOS anymore though.

Rene.
