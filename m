Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273630AbRIYWYh>; Tue, 25 Sep 2001 18:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274162AbRIYWY1>; Tue, 25 Sep 2001 18:24:27 -0400
Received: from adsl-66-121-5-226.dsl.snfc21.pacbell.net ([66.121.5.226]:37959
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S273630AbRIYWYP>; Tue, 25 Sep 2001 18:24:15 -0400
Message-ID: <3BB10424.9070007@switchmanagement.com>
Date: Tue, 25 Sep 2001 15:24:36 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x + dpti2o problem with interrupt sharing?
In-Reply-To: <50DB155AD0CED411988E009027D61DB324D507@otcexc01.otc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bonds, Deanna wrote:

>>A related question is:  should these drivers be able to share 
>>IRQs, i.e. 
>>is it a worthwhile goal to have them operate reliably while sharing 
>>IRQs, or is IRQ-sharing a performance loss and something to 
>>be avoided?
>>
>
>The Adaptec card can share interrupts, but it is not wise to do that with
>another card that is going to be a high priority interrupt.  You most likely
>need to change the motherboard bios settings.  If you are not using your
>onboard IDE you can disable that freeing up another high priority interrupt.
>Otherwise you can manually assign the interrupts through the bios
>
I disabled onboard IDE (secondary channel; primary is needed for CDROM), 
serial, parallel, scsi, usb, and one of two onboard NICs, and now I am 
in a situation with no IRQ sharing.  Unfortunately this BIOS (Phoenix 
ServerBIOS 2 Rel 6.0, Tyan Thunder K7 BIOS v2.07a) does not allow me to 
assign IRQs to PCI slots, and I cannot move the RAID card around because 
it is in a 2U riser card.  Hopefully this will solve the problem.  On a 
broader note, where is the cause of this problem?  You indicated that 
the Adaptec card can share interrupts, so was the problem the 3com 
driver, the 3com hardware, the motherboard, or some other portion of the 
kernel?  It seems that given the scarcity of interrupts, this situation 
probably happens a lot, so we should handle it gracefully (meaning that 
I should go investigate the 3c59x and dpti2o drivers some more if it is 
a problem which is solvable in software).

Thanks,
Brian Strand


