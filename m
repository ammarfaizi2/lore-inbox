Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292898AbSCERMB>; Tue, 5 Mar 2002 12:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293513AbSCERLx>; Tue, 5 Mar 2002 12:11:53 -0500
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:32644 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S292898AbSCERLq>; Tue, 5 Mar 2002 12:11:46 -0500
Message-ID: <3C84FC3E.1070004@kjellander.com>
Date: Tue, 05 Mar 2002 18:11:26 +0100
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
CC: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
In-Reply-To: <Pine.A32.3.95.1020305172410.29684G-100000@werner.exp-math.uni-essen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Michael Weller wrote:
> On Tue, 5 Mar 2002, Oliver Neukum wrote:
> 
> 
>>Am Dienstag, 5. März 2002 06:11 schrieb Greg KH:
>>
>>>On Tue, Mar 05, 2002 at 02:06:07AM +0100, Carl-Johan Kjellander wrote:
>>>
>>>>Attached to each one of these is an Philips ToUCam pro which uses the pwc
>>>>and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)
>>>>
>>>As you are using this closed source module, I suggest you take this up
>>>with that module's author.
>>>
>>Perhaps you could first ask whether the hang can be reproduced
>>without that module loaded ?
>>Secondly, that module is unlikely to cause that kind of trouble.
>>
> 
> I might completely misunderstand the thread, but I would suspect the
> pwc and pwcx modules to be the drivers for the pwc-webcam which blocks
> forever on read syscalls.
> 
> How would you perform the read on the pwc-webcam w/o that driver module?

The pwcx.o module (binary only) is not necessary for operation of
a Philips webcam. The pwc.o module (GPL) is sufficient if you don't need
640x480 resolution, and high fps rates. Pwcx is a module to decompress
the videostream from the camera for higher framerates since the USB
bandwidth is not enough for 640x480x30fps of raw videodata.

The pwc module is included in the standard linux kernel, pwcx is not, but
the problem is still not in pwcx. The problem is reproducible without
pwcx being loaded.

/Carl-Johan Kjellander
please CC me.
-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

