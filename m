Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293706AbSCESrm>; Tue, 5 Mar 2002 13:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293720AbSCESrY>; Tue, 5 Mar 2002 13:47:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46596 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293706AbSCESqy>; Tue, 5 Mar 2002 13:46:54 -0500
Message-ID: <3C85127E.5090406@zytor.com>
Date: Tue, 05 Mar 2002 10:46:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <200203051812.NAA03363@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

> 
> Really?  And you're unconcerned about the impact on the rest of the system
> of a UML grabbing (say) 128M of memory when it starts up?  Especially if it
> may never use it?

 >

It doesn't grab memory, it grabs backing store.  The kernel will swap it 
out as necessary.

> 
> And I don't see anything wrong with starting a bunch of UMLs with a total
> maximum memory exceeding the available tmpfs as long as they don't all need
> all that memory at once.  And, if they do, the patch I just posted will let
> them deal fairly sanely with the situation.


Bullshit.  It means you have moved your system into an insane corner 
case, and you would have been better off denying access in the first place.

	-hpa


