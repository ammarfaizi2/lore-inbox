Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVCVL2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVCVL2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVCVL1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:27:01 -0500
Received: from smtp.telefonica.net ([213.4.129.135]:33957 "EHLO
	tnetsmtp1.mail.isp") by vger.kernel.org with ESMTP id S262647AbVCVLZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:25:15 -0500
Message-ID: <423FE7C5.8080402@telefonica.net>
Date: Tue, 22 Mar 2005 10:39:17 +0100
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
References: <422618F0.3020508@telefonica.net> <20050321141049.5d804609.akpm@osdl.org>
In-Reply-To: <20050321141049.5d804609.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net> wrote:
>  
>
>>I just compiled 2.6.11 from a 2.6.10 configuration for a desktop machine 
>>(with kernel preemption activated).
>>Doing a make oldconfig bring some new options. I selected the default 
>>value (for my system) for them, so I keep configuring "make great kernel 
>>lock preemtive" to true (complete kernel configuration follows).
>>
>>Apart from the ALPS touchpad thing (see "2.6.11: touchpad 
>>unresponsive"), the new kernel keeps:
>>
>>    - Setting randomly "last battery full charge" to a huge value 
>>(example: 400 Ah when max battery capacity is 38 Ah) so I get random 
>>charging/discharging timing patterns
>>    - Locking "softly" the system: for example, preventing new proceses 
>>from spawning. For example, if I suspend the laptop while in Xwindows, 
>>resuming will keep X but new proceses can't be started. Changing to a 
>>virtual console doesn't get past the login step, as a new shell can't be 
>>started.
>>    - Disabling/enabling  double-clicks in the synaptic touchpad. Randomly.
>>
>>All of these symthoms are more or less randomly. As far as I can tell, 
>>everything is ok before suspending but does Random Nasty Things(tm) 
>>after coming out from suspension.
>>
>>Well, at least system clock works better than in 2.6.10.
>>
>>I will try to deactivate the main kernel lock thingie and see if that helps.
>>
>>    
>>
>
>You appear to have about five bugs here.  Do any of them remain in
>2.6.12-rc1?
>  
>
Well, one thing outstands: the synaptic touchpad is now really 
comfortable to use. Almost everything works, including simple and double 
clicks, and scrolling. Dragging is still broken. I must note I'm now 
using a synaptic Xinput driver, as suggested.

The system seems much more stable in regard to suspension/resuming. The 
USB subsystem has kept working the first time I suspended and everything 
came back perfect. The second one in a row, the USB subsystem was 
halted, but doing a "modprobe -r uhci_hcd; modprobe uhci_hcd" made my 
USB periferals (keyboard and mouse) work again.

As for the battery charging pattern, I can't say anything definitive, 
but it looks good ATM.

No more "Ramdom Nasty Things(tm)", the clock works ok and there are no 
issues with proccess spawning.

9/10?
