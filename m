Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281239AbRLLRSP>; Wed, 12 Dec 2001 12:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281322AbRLLRSF>; Wed, 12 Dec 2001 12:18:05 -0500
Received: from hermes.domdv.de ([193.102.202.1]:34322 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S281157AbRLLRRt>;
	Wed, 12 Dec 2001 12:17:49 -0500
Message-ID: <XFMail.20011212181145.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E16ECul-0001kf-00@the-village.bc.nu>
Date: Wed, 12 Dec 2001 18:11:45 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VT82C686 && APM deadlock bug?
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        <jdamery@chiark.greenend.org.uk (Jonathan D. Amery)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Dec-2001 Alan Cox wrote:
>> going wrong during (apm?) screen blanking when there is interrupt activity.
>> Unfortunately the system is frozen solid so there's no chance for any debug
>> trace. It would be nice if someone with detail knowledge of the blanking
>> code
>> could have a look.
> 
> APM power management code is buried in the BIOS. We ask the APM bios nicely
> to blank the display and power manage it. If the APM bios does something
> daft we can't do much about it.
> 
> You can turn apm support off in your XFree86 config and see if that helps
> 
At least in my case this wasn't exactly apm related. It happened too with apm
blanking disabled and only screen blanking without apm blanking occuring.
Preventing screen blanking completely by issuing echo -e "\033[9;0]" prevented
the freeze from happening so I do believe it's not the apm blanking code but
the general console blanking code where the problem occurs (no X, no fb, plain
80x25).


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
