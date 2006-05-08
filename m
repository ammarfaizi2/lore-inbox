Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWEHO04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWEHO04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWEHO04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:26:56 -0400
Received: from smtpout.mac.com ([17.250.248.185]:32200 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932185AbWEHO0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:26:55 -0400
In-Reply-To: <20060507131201.GC5765@ucw.cz>
References: <1146784923.4581.3.camel@localhost.localdomain> <445BA584.40309@us.ibm.com> <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com> <20060505202603.GB6413@kroah.com> <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com> <20060505210614.GB7365@kroah.com> <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com> <20060505222738.GA8985@kroah.com> <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com> <21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com> <20060507131201.GC5765@ucw.cz>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CF99669B-7F47-4290-9F1E-A9585D7CD8D4@mac.com>
Cc: Dave Airlie <airlied@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, Ian Romanick <idr@us.ibm.com>,
       Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Date: Mon, 8 May 2006 10:26:52 -0400
To: Pavel Machek <pavel@suse.cz>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 7, 2006, at 09:12:01, Pavel Machek wrote:
>>> It has everything to do with the 'enable' file. The 'enable' file  
>>> lets you change the state of the hardware without an ownership  
>>> mechanism. Other device users will not be notified of the state  
>>> change. Since the other users can't be sure of the state of the  
>>> hardware when they are activated, they will have to reload their  
>>> state into the hardware on every activation.
>>
>> you seem to miss the fact that this can be done now without the  
>> enable flag, setpci can be used to disable the BARs, again the  
>> enable flag doesn't change that....
>
> ...well, when you launch setpci, you are firmly in 'unsupported'  
> land.  While 'enable' sounds like something where users expect it  
> to be supported.

*Especially* since there are a number of users (including myself) who  
have tendencies to go wandering around sysfs tinkering with the  
available values.  Not having seen this thread, I would have had no  
problem doing "echo -n 0 >enable" on some device thinking that it was  
a fairly standard way to turn off the power to my soundcard when I'm  
not using it, and likely result in a kernel panic because I suddenly  
disabled the BARs on the device out from under the driver.

Cheers,
Kyle Moffett

