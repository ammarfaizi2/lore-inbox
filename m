Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSEXIWC>; Fri, 24 May 2002 04:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSEXIWB>; Fri, 24 May 2002 04:22:01 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:64784 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317115AbSEXIWA>; Fri, 24 May 2002 04:22:00 -0400
Message-ID: <3CEDF811.9020801@loewe-komp.de>
Date: Fri, 24 May 2002 10:21:37 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Greg KH <greg@kroah.com>, gowdy@slac.stanford.edu,
        Andre Bonin <kernel@bonin.ca>, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers
In-Reply-To: <Pine.LNX.4.44.0205230746500.1824-100000@router-273.sgowdy.org> <3CECFBEE.9010802@evision-ventures.com> <20020523160410.GC11153@kroah.com> <3CED2CF5.5050202@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Uz.ytkownik Greg KH napisa?:
> 
>> Anyway, here's the documentation that you need:
>>     The module usb-ohci is now gone.  Use ohci-hcd instead.
>>
>> The people with UHCI controllers have a big more documentation to read:
>>     The module uhci is now gone.  If you used this module, use
>>     uhci-hcd instead.  The module usb-uhci is now gone.  If you used
>>     this module, use usb-uhci-hcd instead.  If you have a preference
>>     over which UHCI module works better for you, please email
>>     greg@kroah.com your comments, as one of these modules will be
>>     going away in the near future.
> 
> 
> Thank's that is explaining it.
> But I would have loved it if it appeared with + in front in
> the patch somewhere. That's the only true problem I had.
> OK?
> 
> BTW.> usb-ohci seems to be a more reasonable name, since
> it tells me directly - hey buddy I'm USB the -hcd doen't
> tell me anything in addition and is entierly redundant, or
> is there a ohci.o module there?
> 
> And why not just doing the following.
> 
> 1. Rename usb-ohci to usb-ohci-old
> 
> 2. Rename ohci-hcd to usb-ohci
> 
> Much less grief and guessing what happens :-).
> 
> Just a suggestion.
> 

You do not understand the _cause_ for the rename.

hcd stands for Host Controller Device. The names mark them as that.
Now you can argue, that all the SCSI controller modules do not have
HBC (host bus controller) in their name - and then look at the
different naming of the other scsi modules:

scsi_mod.o  sd_mod.o  sg.o  sr_mod.o  st.o

Also not very intuitiv. We could put them in different subdirs...



