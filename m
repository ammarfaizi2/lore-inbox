Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161694AbWKEUQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161694AbWKEUQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161697AbWKEUQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:16:49 -0500
Received: from terminus.zytor.com ([192.83.249.54]:51420 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161694AbWKEUQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:16:48 -0500
Message-ID: <454E46A8.20106@zytor.com>
Date: Sun, 05 Nov 2006 12:16:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Maurizio Lombardi <m.lombardi85@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>	 <454A76CC.6030003@cosmosbay.com>	 <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz> <c87e555d0611050503q5d344ac9r8726d61115b024b3@mail.gmail.com>
In-Reply-To: <c87e555d0611050503q5d344ac9r8726d61115b024b3@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurizio Lombardi wrote:
> On 11/4/06, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
> 
>> free space is organized in lists of free runs
>> and converted to bitmap only in case of
>> extreme fragmentation.
> 
> There is a performance reason to prefer lists of free blocks rather than 
> bitmap?
> 
> I read from [Tanenbaum: Operating System, Design and Implementation II
> ed. ] that lists are better than bitmap only when disk is almost full.
> 

Yes, if you have a truly random access medium.

If you have media like physical disks, where fragmentation costs you, 
the lists will kill you dead in no time at all.

	-hpa
