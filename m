Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbREVIxG>; Tue, 22 May 2001 04:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbREVIw4>; Tue, 22 May 2001 04:52:56 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:20419 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262593AbREVIwj>; Tue, 22 May 2001 04:52:39 -0400
Message-ID: <3B0A28C0.2FFFC935@TeraPort.de>
Date: Tue, 22 May 2001 10:52:16 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: hpa@transmeta.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Hi, 
>> 
>> while trying to enhance a small hardware inventory script, I found that 
>> cpuinfo is missing the details of L1, L2 and L3 size, although they may 
>> be available at boot time. One could of cource grep them from "dmesg" 
>> output, but that may scroll away on long lived systems. 
>> 
>
>Any particular reason this needs to be done in the kernel, as opposed 
>to having your script read /dev/cpu/*/cpuid? 
>
>        -hpa 

 terse answer: probably the same reason as for most stuff in
/proc/cpuinfo :-)

 Seriously, is there any kind of documentation on for the stuff you
mention? I am willing to learn. Isn't the cpuid just a kind of
serialnumber? The one that caused the big flame wars when Intel
introduced the concept? In any case, on my system(s) there seems to be
no device behind those files. On some systems, there is even no
"/dev/cpu" directory.

 I agree in a way that the changes to processor.h are not neccessary -
unless other parts of the kernel are interested in those values. I
probably should change that to make the thing easier to digest.

Martin
