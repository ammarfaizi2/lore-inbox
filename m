Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293513AbSCERWx>; Tue, 5 Mar 2002 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293614AbSCERWn>; Tue, 5 Mar 2002 12:22:43 -0500
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:34948 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S293513AbSCERW3>; Tue, 5 Mar 2002 12:22:29 -0500
Message-ID: <3C84FEC8.5080801@kjellander.com>
Date: Tue, 05 Mar 2002 18:22:16 +0100
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
In-Reply-To: <3C8419FF.10103@kjellander.com> <20020305051146.GA7075@kroah.com> <200203051612.g25GCtc23752@fachschaft.cup.uni-muenchen.de> <3C84FAB4.7020702@kjellander.com> <20020305170047.GA9388@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Mar 05, 2002 at 06:04:52PM +0100, Carl-Johan Kjellander wrote:
> 
>>Oliver Neukum wrote:
>>
>>>Am Dienstag, 5. März 2002 06:11 schrieb Greg KH:
>>>
>>>
>>>>On Tue, Mar 05, 2002 at 02:06:07AM +0100, Carl-Johan Kjellander wrote:
>>>>
>>>>
>>>>>Attached to each one of these is an Philips ToUCam pro which uses the pwc
>>>>>and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)
>>>>>
>>>>>
>>>>As you are using this closed source module, I suggest you take this up
>>>>with that module's author.
>>>>
>>>>
>>>Perhaps you could first ask whether the hang can be reproduced
>>>without that module loaded ?
>>>Secondly, that module is unlikely to cause that kind of trouble.
>>>
>>The problem can be reproduced on a computer that has not loaded pwcx.o
>>after boot. The problem is not caused by pwcx.o at all.
>>
> 
> But you are reading from the pwc driver, right?
> Have you asked the author of that driver about this?

Since the problem isn't reproducible on the pwc-camera on the onboard
UHCI controller, I tend to think it isn't a problem with the PWC driver
but with either the hardware or the usb-ohci driver. If 3 out of four
cameras has the same problem, and the fourth doesn't the problem is
easiest to find if you look at the difference between them, the UHCI
vs OHCI controller/drivers.

And I think he is subscribed to this list. I don't want to bother him to
much since he has gotten tons of bugreports that has turned out to be
bugs in uhci.o, usb-uhci.o and usb-ohci.o over the last year.
/Carl-Johan Kjellander
-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

