Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVGLLwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVGLLwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVGLLuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:50:12 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:682 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261363AbVGLLtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:49:39 -0400
Message-ID: <42D3AE47.7070208@lifl.fr>
Date: Tue, 12 Jul 2005 13:49:27 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ken Moffat <ken@kenmoffat.uklinux.net>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net> <Pine.LNX.4.58.0507112044001.3450@ppg_penguin.kenmoffat.uklinux.net> <200507120755.03110.kernel@kolivas.org> <42D3782F.7070104@lifl.fr> <Pine.LNX.4.58.0507121131001.7702@ppg_penguin.kenmoffat.uklinux.net> <Pine.LNX.4.58.0507121203450.7944@ppg_penguin.kenmoffat.uklinux.net>
In-Reply-To: <Pine.LNX.4.58.0507121203450.7944@ppg_penguin.kenmoffat.uklinux.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07/12/2005 01:11 PM, Ken Moffat wrote/a écrit:
> On Tue, 12 Jul 2005, Ken Moffat wrote:
> 
> 
>> I was going to say that niceness didn't affect what I was doing, but
>>I've just rerun it [ in 2.6.11.9 ] and I see that tar and bzip2 show up
>>with a niceness of 10.  I'm starting to feel a bit out of my depth here
> 
> 
> OK, Con was right, and I didn't initially make the connection.
> 
>  In 2.6.11, untarring a .tar.bz2 causes tar and bzip2 to run with a
> niceness of 10, but everything is fine.
> 
>  In 2.6.12, ondemand _only_ has an effect for me in this example if I
> put on my admin hat and renice the bzip2 process (tried 0, that works) -
> renicing the tar process has no effect (obviously, that part doesn't
> push the processor).
> 
> So, from a user's point of view it's broken.
Well, it's just the default settings of the kernel which has changed. If 
you want the old behaviour, you can use (with your admin hat):
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice
IMHO it seems quite fair, if you have a process nice'd to 10 it probably 
means you are not in a hurry.

Just by couriosity, I wonder how your processes are automatically 
reniced to 10 ?


Eric
