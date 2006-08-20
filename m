Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWHTR2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWHTR2a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWHTR2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:28:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:8363 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750882AbWHTR23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:28:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uQfBLCcjehMZKQDmR0DdDTPB75Faii3MCI0/Sg/Xn6BQwwncFSNiMMyeud1tvFjB0XbxqiIzimgVnzVDe4J0KzVqnEs+T0ApWNFWfogi+cco8r9H5SdiFsfUWBdHWOUfpHMRqhZQGk+PVc8JDhsLuQQPTyB5eCrgzv82x760g2A=
Message-ID: <44E89BBA.9090809@gmail.com>
Date: Sun, 20 Aug 2006 13:28:26 -0400
From: Ryan Newberry <brnewber@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 7027] New: CD Ripping speeds slow with 2.6.17
References: <200608191800.k7JI0ML0015395@fire-2.osdl.org>  <20060819111437.a88f71cd.akpm@osdl.org>  <1156062478.6690.65.camel@Homer.simpson.net>  <1156068220.6034.1.camel@Homer.simpson.net> <1156072300.5052.7.camel@Homer.simpson.net> <Pine.LNX.4.61.0608201548180.9027@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608201548180.9027@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>> I'm skeptical.  Is the source for this application available?  I'd like
>>>> to see this problem.
>>>>         
>>> (never mind.  saw your other post, found source)
>>>       
>> Hm.  I can't get better than 1.4x rip speed out of it with a stock SuSE
>> 10.1 kernel (2.6.16).  It's also using truckloads of cpu, whereas the CD
>> rippers that came with this distro use a percent or two.
>>     
>
> What command did you use to rip?
>
>
>
> Jan Engelhardt
>   
The ripper he's using is ripoff I assume (source code here: 
http://prdownloads.sourceforge.net/ripoffc/ripoff-0.8.tar.gz?download  
extraction functionality contained in src/RipOffExtractor.c) . It uses 
libparanoia to do its job, like the cdparanoia command. On my system, 
ripoff has high CPU usage with a 2.6.16 kernel as well, but it reports a 
9.0x rate on average.
Could the fact that it has such high CPU usage be a possible reason I am 
experiencing a slower ripping speed (1.2x) when the patch that was git 
bisected is applied?

-- 
Ryan Newberry
http://ripoffc.sourceforge.net
"All mankind is divided into three classes: those that are immovable, those that are movable, and those that move." - Benjamin Franklin

