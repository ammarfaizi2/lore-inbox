Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271134AbTHHB3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271141AbTHHB3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 21:29:10 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:40862 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271134AbTHHB3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 21:29:06 -0400
Message-ID: <3F32FCDF.9000903@sbcglobal.net>
Date: Thu, 07 Aug 2003 20:29:03 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ACPI Power Button Event problems(?)
References: <3F31F6FD.8030001@sbcglobal.net> <1060285317.3351.7.camel@litshi.luna.local>
In-Reply-To: <1060285317.3351.7.camel@litshi.luna.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did the cat /proc/acpi/event shortly after implementing my script and 
finding out it was continually being called after pressing the power 
button.  I got/(still get):
button/power PWRF 00000080 00000001
...
button/power PWRF 00000080 00006bbb
... etc.

Of course, with 2.6.0-test1-mm2, it would stop when I restarted acpid or 
pushed the power button again.  With 2.6.0-test2-mm1 that has changed in 
that stopping the events requires a reboot.

I can recompile my 2.4.18 with ACPI support and see what happens if that 
is necessary...just let me know.

Thanks.

Micha Feigin wrote:

>On Thu, 2003-08-07 at 09:51, Wes Janzen wrote:
>  
>
>>I'm having an interesting, and relatively benign problem with ACPI 
>>events.  I downloaded the ACPI daemon from SourceForge and with 
>>2.6.0-test1-mm2 when I pressed the power button, ACPI would be deluded 
>>with PWRF events until I pushed the button again or acpid was 
>>restarted.  That's easy enough to work around, but with 2.6.0-test2-mm1 
>>the events never stop.  Restarting the daemon makes no difference, nor 
>>does pushing the button have any effect.  That wouldn't be too big of a 
>>problem if I was using the power button to restart the PC, but I'm using 
>>the event to kill sawfish since it likes locking up (and disregarding 
>>any keyboard input) leaving me with no recourse but to press the reset 
>>button otherwise.  So, it works great for the first lockup, but I can't 
>>reset the power button event so I'm stuck with the reset button on the 
>>second round.  Unless I want to reboot, which I'd rather not. 
>>
>>Is this a bug in 2.6.0-test2-mm1 or was the bug the fact it could be 
>>cancelled in 2.6.0-test1-mm2?
>>
>>Thanks,
>>
>>-Wes-
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>I am guessing that it is not a bug in acpid since stop it didn't help.
>You could try a
>cat /proc/acpi/event
>to make sure that you are actually getting these events no stop.
>I am guessing that it is a faulty dsdt since you got the same the
>behavior on the different kernel.
>Can you tell if this also happens with 2.4 kernel?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

