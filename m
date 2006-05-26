Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWEZLBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWEZLBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWEZLBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:01:13 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:23711 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751393AbWEZLBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:01:12 -0400
Message-ID: <4476DF40.8040403@aitel.hist.no>
Date: Fri, 26 May 2006 12:58:08 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: Jon Smirl <jonsmirl@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com> <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru> <4476A951.2070003@aitel.hist.no> <4476BD28.8040405@ums.usu.ru>
In-Reply-To: <4476BD28.8040405@ums.usu.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:
> Helge Hafting wrote:
>> "Which of the two keyboards to read, which of the three screens to use
>> for messages" is not a problem.  The kernel would use whatever devices
>> is associated with the primary console - any extra devices would be 
>> left alone.
>> The console is normally one particular keyboard (or possibly all of 
>> them),
>> and /dev/fb0 in case of graphical console.  Other framebuffers are
>> not the primary console.
>
> I am not sure how this can be achievable, assuming that udev is 
> responsible for loading framebuffer modules. Since it loads them in 
> parallel, the registration order is essentially random. See the 
> following Debian bugs about other subsystems:
So what?  In that case, it is essentially random _which_ display you
get your PANIC on, but you will get it on one of them.

Of course this case is easily fixed by loading the preferred
framebuffer driver before running udev.  That way, it grabs
/dev/fb0 before anything else.

Helge Hafting
