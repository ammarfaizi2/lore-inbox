Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262225AbSJJV30>; Thu, 10 Oct 2002 17:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSJJV30>; Thu, 10 Oct 2002 17:29:26 -0400
Received: from ns1.weihenstephan.org ([212.82.168.3]:44469 "EHLO 
	mail.weihenstephan.org") by vger.kernel.org with ESMTP
	id <S262225AbSJJV3Z>; Thu, 10 Oct 2002 17:29:25 -0400
Date: Thu, 10 Oct 2002 23:35:30 +0200
Subject: Re: Xbox Linux Kernel Patches Questions
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       Xbox-linux-devel@lists.sourceforge.net
To: Alan Cox <alan@redhat.com>
From: Michael Steil <mist@c64.org>
In-Reply-To: <200210102051.g9AKpUo31633@devserv.devel.redhat.com>
Message-Id: <333B8114-DC98-11D6-B7BF-003065E1FB16@c64.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.543)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you tell the xbox by the subsystem id on the root bridges ?

Yes, these are unique.

>> Do we have a chance for our kernel fixes for the Xbox to be included
>> into the standard kernel? All our changes are tiny and #ifdef
>> CONFIG_XBOX and change nothing on a i386 PC or on any other
>> architecture.
>
> Probably. I suspect the primary questions are political/lawyer ones 
> rather than
> technical ones. Things like the IDE drive password are touchy obviously
> but that can be done from an initrd loaded with the kernel I guess.

Yes, we have already moved the IDE unlock code into the bootloader and 
it won't be needed in the kernel for most systems, so it won't have to 
be included into the main kernel. All other changes shouldn't be 
(politically/legally) problematic in any way.

>> Would it be better to have a runtime check at kernel initialization to
>> detect the Xbox and put all Xbox specific code between if (xbox) {}?
>
> IMHO yes.

So all all Xbox specific code would look like this:
#ifdef CONFIG_XBOX_SUPPORT
if (xbox) {
	...
}
#endif

Where would we put out Xbox detection code? If it detects the Xbox as 
described above, CONFIG_XBOX_SUPPORT will depend on CONFIG_PCI.

   Michael

