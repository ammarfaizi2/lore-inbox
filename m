Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVFYXlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVFYXlj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 19:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVFYXli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 19:41:38 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:61163
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261382AbVFYXlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 19:41:21 -0400
Message-ID: <42BDDD7C.7090402@linuxwireless.org>
Date: Sat, 25 Jun 2005 17:41:00 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org, borislav@users.sourceforge.net,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net,
       mlord@pobox.com
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz> <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>
In-Reply-To: <20050625200953.GA1591@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Sat, Jun 25, 2005 at 01:13:17PM -0500, Alejandro Bonilla wrote:
>
>  
>
>>I have a question here, how do you guys think that the head is parked, 
>>is it done by the controller directly, which then sends the command to 
>>the HD to park the head, or this is done by the operating system in some 
>>kind of way?
>>
>>I think the OS or user space is too slow like to react to send a park 
>>command to the hard drive, so this most be done directly by the embedded 
>>controller, but still I think it needs some input from the OS, to 
>>initialize it's settings.
>>    
>>
>
>The only way to park a drive is to send a command to it through the IDE
>interface. This can't be done by the controller itself, since the
>controller in the ThinkPad is a classic Intel ICH chip which only passes
>commands around.
>
>The OS is definitely fast enough for this kind of task, it's doable even
>in userspace, although not easy.
>
>  
>
>>i.e. after all, in windows you do have the settings in the software
>>for HDAPS, but it looks like it is _not_ managed by the operating
>>system at all if there is some type of action to  be taken. This is
>>also probably why HDAPS won't kick in until booted, and that is
>>because it needs to load its config setup by the software.
>>    
>>
>
>  
>
>>This is what I think, please correct me if I'm saying something crazy.
>>    
>>
>
>It is definitely all done by the windows kernel driver.
>
>  
>
OK, So if this is done by the user space then I think we can play more 
with it? I guess that we could do a type of hdparm -F or hdparm -S to 
spin down the drive or maybe there is a way to add feature to hdparm to 
park the drive itself.

Aside from what we should do when we get the data... How can we/us/I 
start checking and see if we can find any response from the embedded 
controller?

Do we have to backengineer everything, can we get anything of this from 
IBM-ACPI, or our only way to go here is see if IBM will do anything?

Thanks for all the answers. I really don't want to drop the topic, so 
that we can figure this one out.

.Alejandro
