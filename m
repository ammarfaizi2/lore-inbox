Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135962AbRDTQZz>; Fri, 20 Apr 2001 12:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135963AbRDTQZp>; Fri, 20 Apr 2001 12:25:45 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:45577 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135962AbRDTQZ3>;
	Fri, 20 Apr 2001 12:25:29 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: German Gomez Garcia <german@piraos.com>
Date: Fri, 20 Apr 2001 18:24:31 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Re[2]: Problems with i2c-matroxfb and latest kernel
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A614240FE8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 01 at 18:18, German Gomez Garcia wrote:
> On Fri, 20 Apr 2001 18:01:59 MET-1 Petr Vandrovec <VANDROVE@vc.cvut.cz> wrote:
>         I've got it conected to the RGB->SVIDEO cable that was included with
> the Matrox G400 MAX, and the SVIDEO is connected to a VIDEO->RF conversor in
> order to distribute to other rooms. And what is the caller when modprobing?
> modprobe? the driver for the g400 i2c? 

Yeah. RGB->SVIDEO cabel has connected SDA-SCL together, so when it transmits
zero data bit, it will find clocks held in zero... Caller is i2c-matroxfb
procedure which calls i2c_add_bit_bus() ... It calls it with 1s timeout
too, but it is another story... I believed that it is 100ms timeout...

> >   You should compile i2c-algo-bit as module and use insmod it
> > with 'bit_test=1' parameter. It should do some tests on these pins
> > to find whether they are stuck in 0 or in 1. You can also try
> > 'i2c_debug=3' ...
> 
>         I'll check it and mail you with results.

bit_test=1 should say 'DDC#2: SCL unexpected low while pulling SDA low!'...
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
