Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293232AbSCEK5U>; Tue, 5 Mar 2002 05:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293279AbSCEK5K>; Tue, 5 Mar 2002 05:57:10 -0500
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:31875 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S293232AbSCEK46>; Tue, 5 Mar 2002 05:56:58 -0500
Message-ID: <3C84A46D.90800@kjellander.com>
Date: Tue, 05 Mar 2002 11:56:45 +0100
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
In-Reply-To: <3C8419FF.10103@kjellander.com> <20020305051146.GA7075@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Mar 05, 2002 at 02:06:07AM +0100, Carl-Johan Kjellander wrote:
> 
>>Attached to each one of these is an Philips ToUCam pro which uses the pwc
>>and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)
>>
> 
> As you are using this closed source module, I suggest you take this up
> with that module's author.

The problem exists even when pwcx.o isn't loaded so the bug is not in there.

# lsmod --version
lsmod version 2.4.13
# lsmod
Module                  Size  Used by    Tainted: P
eepro100               17520   1
appletalk              19596   0  (autoclean)
ipchains               30884  12
md                     43712   0  (unused)
audio                  38080   0  (unused)
soundcore               3428   8  [audio]
pwc                    38592   1
usb-uhci               21348   0  (unused)
usb-ohci               17920   0  (unused)
usbcore                49440   1  [audio pwc usb-uhci usb-ohci]

The test machine has not had pxwc.o loaded after bootup and the problem
is still there.

/Carl-Johan Kjellander
please CC me.
-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

