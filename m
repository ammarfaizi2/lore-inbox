Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287183AbSABXJY>; Wed, 2 Jan 2002 18:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287181AbSABXJQ>; Wed, 2 Jan 2002 18:09:16 -0500
Received: from ns1.webley.com ([207.25.7.30]:29961 "EHLO skip1.webley.com")
	by vger.kernel.org with ESMTP id <S287173AbSABXIK>;
	Wed, 2 Jan 2002 18:08:10 -0500
Message-ID: <3C3392CE.2030002@webley.com>
Date: Wed, 02 Jan 2002 17:07:58 -0600
From: Nicholas Harring <nharring@webley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: timothy.covell@ashavan.org
CC: Tony Hoyle <tmh@nothing-on.tv>, adrian kok <adriankok2000@yahoo.com.hk>,
        linux-kernel@vger.kernel.org
Subject: Re: system.map
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201021930.g02JUCSr021556@svr3.applink.net> <3C336209.8000808@nothing-on.tv> <200201022006.g02K6vSr021827@svr3.applink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell wrote:

>On Wednesday 02 January 2002 13:39, Tony Hoyle wrote:
>
>>Timothy Covell wrote:
>>
>>>	Of course, you can copy over the new System.map
>>>file to /boot,  but their is no (easy) way of having more than
>>>one active version via "lilo" or "grub".   And that could be
>>>considered a deficiency of the Linux OS.
>>>
>>????  Just call it System.map-2.2.17, System.map-2.5.1, etc.  Sounds
>>pretty 'easy' to me.
>>
>>'make install' does all this for you, btw.
>>
>>Tony
>>
>
>Not on grub.  I quote:
>	It is also possible to do "make install" if you have lilo 
>	installed to suit the kernel makefiles,
>  	but you may want to check your particular lilo setup first.
>
>But, on my grub based system, I have to:
>
>1.  "make bzlilo"  which creates vmlinuz and System.map 
>and puts them in / and not in /boot.  (make bzlilo is easier to use
>than bzimage)
>
>2. cp /vmlinuz /boot/vmlinuz-x.y.x  ;  cp /System.map /boot/System.map-x.y.z
>
>3. rm /boot/System.map ; ln -s /boot/System.map-x.y.z /boot/System.map
>
>4. vi /boot/grub.conf (or /etc/grub.conf) and put in new kernel boot entry.
>
>5. sync;sync;shutdown -r now
>
>
If you export INSTALL_PATH=/boot then the copying and removing and 
relinking will be unnecessary.

Nick Harring
Webley Systems, Inc.


