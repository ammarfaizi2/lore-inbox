Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWCUVUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWCUVUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCUVUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:20:50 -0500
Received: from terminus.zytor.com ([192.83.249.54]:28038 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751416AbWCUVUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:20:49 -0500
Message-ID: <44206E1C.6090808@zytor.com>
Date: Tue, 21 Mar 2006 13:20:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com> <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com> <Pine.LNX.4.61.0603211854150.21376@yvahk01. <442050C8.1020200@zytor.com> <44205BC5.9040200@cfl.rr.com>
In-Reply-To: <44205BC5.9040200@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> H. Peter Anvin wrote:
> 
>> Probably it would be worth trying to create "aux.h" under XP and see 
>> what happens.  Unfortunately I don't have a 'doze system handy at the 
>> moment.
> 
> 
> kernel32.dll's CreateFile() and other apis normally perform translation 
> which includes special handling for dos device names including AUX.  You 
> can bypass this by prefixing the absolute file name with the string 
> "\\?\" and this will allow you to create a file named AUX.  It also 
> allows you to reference file names with absolute paths greater than 255 
> characters.
> 

So, in other words, Windows will let you create these files; it will 
just make you just through hoops to access them.

Sounds like they should be able to be legitimately created.  If the 
shortnames are mangled, even DOS or Win9x could access them using the 
shortname.

	-hpa

