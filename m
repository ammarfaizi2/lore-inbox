Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263611AbUD2Gev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbUD2Gev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUD2Gev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:34:51 -0400
Received: from zasran.com ([198.144.206.234]:57763 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S263611AbUD2Geg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:34:36 -0400
Message-ID: <4090A1FA.1070202@bigfoot.com>
Date: Wed, 28 Apr 2004 23:34:34 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
References: <40853060.2060508@bigfoot.com> <200404280741.08665.dtor_core@ameritech.net> <408FFC2A.3080504@bigfoot.com> <200404281824.05044.dtor_core@ameritech.net>
In-Reply-To: <200404281824.05044.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Wednesday 28 April 2004 01:47 pm, Erik Steffl wrote:
>>Dmitry Torokhov wrote:
>>
>>>What protocol are you using in XFree?
>>
>>   that's irrelevant, I got the results above without X running (by 
> 
> No, it is not. Please change protocol in XF86Config to ExplorerPS/2.
...
> Kernel only provides emulation of 3 protocols via /dev/psaux: bare PS/2,
> IntelliMouse PS/2 and Explorer PS/2. Since your program does not issue
> Intellimouse or Explorer protocol initialization sequences it gets just
> bare PS/2 protocol data - 2 axis, 3 buttons. Extra buttons are mapped onto
> first 3. For exact mapping consult drivers/input/mousedev.c

   thanks, that makes sense, I tried ExplorerPS/2, it works better, the 
wheel works but side button is still same as button 2.

   would it be different if I used /dev/input/mouse0? or 
/dev/input/mice?  kernel Documentation/input/input.txt seems to be 
fairly old (mentions  2.5/2.6 in future tense) and it says to use 
"ExplorerPS/2 if you want to use extra (up to 5) buttons" when 
discussing what /dev/input/mouse0 provides. Does that mean that there's 
no way to use extra side button (which is the sixth button)?

	erik
