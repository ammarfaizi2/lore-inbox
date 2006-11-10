Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424410AbWKJUiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424410AbWKJUiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966113AbWKJUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:38:11 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:12232 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S966112AbWKJUiK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:38:10 -0500
Message-ID: <4554E2DF.2020102@gmail.com>
Date: Fri, 10 Nov 2006 21:36:47 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jano <jasieczek@gmail.com>
CC: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>	 <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>	 <45537B67.6050804@gmail.com> <d9a083460611100739v531b0293i5ae5fd8d3ccee800@mail.gmail.com>
In-Reply-To: <d9a083460611100739v531b0293i5ae5fd8d3ccee800@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jano wrote:
> 2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
>>
>> In such cases google is very helpful ;).
>>
> 
> Sorry, my mistake :D.
> 
>>
>> No, I meant strace(1):
>> strace mount /dev/hdbX /home
>>
> 
> # strace mount /dev/hdb1 > file1
> # strace mount /home > file2

yeah. Either redirect stderr by 2> file1 (this will contain mount errors too) or
use strace -o file1

[snip]
>> And try to turn "VIA82CXXX chipset support" to <*>, i.e. built-in
>> (somebody
>> holds regions of ide0 and ide1, let's try via driver to probe first).
>>
> 
> Also done. Haven't changed anything.
> 
> Hope that strace output will be helpful. As far as I'll be able to
> save the results. Any suggestions?

When you boot with init=/bin/bash not to allow system to start scripts, does it
work? (add init=/bin/bash kernel parameter)

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
