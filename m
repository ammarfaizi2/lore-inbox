Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbSLSM2z>; Thu, 19 Dec 2002 07:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbSLSM2z>; Thu, 19 Dec 2002 07:28:55 -0500
Received: from cc125153-a.ensch1.ov.home.nl ([217.120.134.19]:10488 "HELO
	luggage.discworld.org") by vger.kernel.org with SMTP
	id <S267636AbSLSM2y>; Thu, 19 Dec 2002 07:28:54 -0500
Message-ID: <3E01BD20.4080608@home.nl>
Date: Thu, 19 Dec 2002 13:35:44 +0100
From: Robert Boermans <r.boermans@home.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pawel Kot <pkot@linuxnews.pl>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.24-rc1
References: <Pine.LNX.4.33.0212170113350.14563-100000@urtica.linuxnews.pl>
In-Reply-To: <Pine.LNX.4.33.0212170113350.14563-100000@urtica.linuxnews.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Kot wrote:

>Is it the following chunk? (I can't find anything more appropriate)
>@@ -1378,7 +1378,8 @@
>                        return;
>
>                case X86_VENDOR_AMD:
>-                       init_amd(c);
>+                       if(init_amd(c))
>+                               return;
>                        return;
>
>                case X86_VENDOR_CENTAUR:
>What does it fix?
>
>pkot
>  
>
i assume there was more to the patch?

i mean first it did init_amd(c) and then return
now it does init_amd(c) and returns in the if or right on the next line, 
so that's the same with extra bloat.

confused,

Robert Boermans.

