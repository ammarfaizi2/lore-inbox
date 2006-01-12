Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWALJhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWALJhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWALJhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:37:42 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:38059 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964836AbWALJhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:37:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=PT1jTxDRJYYvwjrtTdlggDERKVsFnEPZ8XlsfWjg4ASCk1RL20JgMWhiVqNr0GnXx/lAGH/8cHQ1NbSNtHKcclBPfSoJTNwxDXuFBEbbxBLUUp5sZ/C9unVll0tfNRwgI4Dw8sN9jqiMcasl6QzQSENjRx0Cwlan4dYDTEzwieA=
Message-ID: <43C62360.9050705@gmail.com>
Date: Thu, 12 Jan 2006 10:37:36 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051210)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>, tiwai@suse.de
Subject: Re: [BUG 2.6.15-git5] new alsa power management completly broken
References: <20060111234810.3ffe241c.akpm@osdl.org> <20060112085837.GD1670@elf.ucw.cz>
In-Reply-To: <20060112085837.GD1670@elf.ucw.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek ha scritto:

>On St 11-01-06 23:48:10, Andrew Morton wrote:
>  
>
>>swsusp problems...
>>    
>>
>
>Where? :-)
>  
>
nowhere now :)
i still have problems on my noteboot about irq 14 not cared...(since ages!)
i'll try to do something, if i can't fix i'll report.
(stopping here cause going OT)

>  
>
>>sorry for delay, however i tested it and works perfectly.
>>
>>just 2 things to notice:
>>1) [unrelated to this bug] swsusp ram pages write and read is really
>>slower than 2.6.14 one. i didn't follow changes, so don't know what
>>happened
>>    
>>
>
>That's a feature. echo 0 > /sys/power/image_size should make it behave
>like 2.6.14.
>
>  
>
ok, so i think i should check docs (i hope they are updated)

>>2) when i suspend i continue to see errors 0x660 in my tty. The strange
>>thing is that after resume they are no more in dmesg!
>>strange. however, as i wrote before, it works.
>>    
>>
>
>That's not so strange. Messages that happen after memory snapshot are
>lost (of course).
>								Pavel
>  
>
ok, sure, but before this patch i had them in my dmesg.
the patch shouldn't have changed the saving sequence, so..why this happens?
and, however some errors still occour.

alsa guys should judge if they are revelant to trace and fix the source
of 0x660.

Thanks for support

--
Patrizio Bassi
www.patriziobassi.it
