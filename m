Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313117AbSDIJdT>; Tue, 9 Apr 2002 05:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313118AbSDIJdS>; Tue, 9 Apr 2002 05:33:18 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:10504 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S313117AbSDIJdR>;
	Tue, 9 Apr 2002 05:33:17 -0400
Date: Tue, 9 Apr 2002 10:33:41 +0100
From: Chris Wilson <chris@jakdaw.org>
To: Chris Wilson <chris@jakdaw.org>
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org, zwane@linux.realnet.co.sz
Subject: Re: P4/i845 Strange clock drifting
Message-Id: <20020409103341.3a91d5dd.chris@jakdaw.org>
In-Reply-To: <20020408144923.4566d3fc.chris@jakdaw.org>
Organization: Hah!
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart_Tue__9_Apr_2002_10:33:41_+0100_08f0c3b0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__9_Apr_2002_10:33:41_+0100_08f0c3b0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



An update...
 
> I've now applied your patch so that APIC's get enabled even though the
> bios has disabled them. 
> 
> I really should have saved the dmi messages to another machine when the
> machine first came up as it appears to have crashed now :(
> 
> The machine was completely idle other than for an ssh session running
> ntpdate every ten minutes (my original problem is that the clock appears
> to stop/slow down periodically). 

Back without APIC now - and the machine is stable again. Clock is still
screwed however.

> > This should work (and is known to work on many P6 and K7 boards),
> > but your BIOS may have problems with the local APIC.
> > - does apm --suspend work? does the resume afterwards work?
> 
> I don't have APM support compiled in and will have disabled anything power
> management related in the BIOS setup.

Last night I set another machine doing:

(while sleep 600; do ssh screwedbox ntpdate goodbox; done) | tee ntp.log

The results (attached) are interesting. It appears that my clock drift
problem occurs every hour.  Perhaps it is APM related?? Load doesn't seem
to make any difference. And there's never two consecutive ntpdate's that
are a long way out - suggesting that whenever the problem occurs it's then
fixed temporarily when ntpdate sets the clock.

Anyone have any suggestions as to what to try next? Shall I try compiling
a kernel with APM support and see if I can turn off anything that might be
causing troubs? I'm *sure* I turned off any mention of power management in
the BIOS....

Regards,

Chris
--Multipart_Tue__9_Apr_2002_10:33:41_+0100_08f0c3b0
Content-Type: application/octet-stream;
 name="ntp.log.gz"
Content-Disposition: attachment;
 filename="ntp.log.gz"
Content-Transfer-Encoding: base64

H4sICG2zsjwCA250cC5sb2cAlZnNruREDIX3PEVegMj/5eodz4FYjJgeCSRgNLeH58cVdG8csyDe
tqJPlRz7HLt68+2nr982nA+yB8/tz9fXz59ez5/J4JfH9unz79/fXtvrtz+e29vz29/P9STtaL7j
bttfX768PV8b7GDAIvHIrz9sH0C2h0ACSgdIPNkLUAKICegBfHs9v/4fDgfvLOikBagBpBM4qHNC
ZRyQgQQPCCAnoLVe2cesQAygnEBviSIkRAUYKosmYEsUZlYpQPaHprJxb31DEK6vLPMBqWwm3VUZ
eMc5zeoJNYCpbGZLFB1KlzokfEAAz7JhaIlC020WIBZgSxQRmfWEFEBOwJYoPLh8QwxneMBZh4yt
ThEY/wFKAbZEYTeCAlwqn4XNBA1zAJ5qfAHSobIlYEsUnTylAJfKnoDeK5uBVoBL5bP1mHuicHRf
AYbKCAnYE2WE0AUYKmMqbOnZF1jY/RWoBdizL/N5/Ya8VMbUKXI3U8Rwp+EyqABDZUyFrdSLUb/G
aABDZUyFrT1RwLACl8qpsHtBLzpcC3CpPBKw1ymgOAtwqZwK27zpNu+ZMg8gwFKZUmE3gv5HiNHB
4L0QP4hrYMJEtJt1Q277BAKSAgyZKVV2K+kFKXKyAENmSpXdSnqkAWAFGDJTquxW0sePAvWEITOl
yp6tVokQwCvwCGZKld1MeoP3AfEDuFQ+K1t6SR/+aVaAS2VPQLmbUjtHI+souKXxTDhvZpR6AYbG
fDaK9HI+RqsJBRgaMyag9UYbLVV4xDKffSIEzYxSLkAswN7wZSSzAENj5gTsudcElQIMlflsPOG7
E7HvHMMpj4KTgmtJYliL+gjltPVIL+VpTL5KcoRy2nqkl/JRM6UKj1BOW49Ibx52LJIcoZyBvZSP
tlIsQF7rbQLabWOAOasxHJGccb2MV47JpgCXxskJm8u8hblegHJonIHtjNcCXBona+1lfKSdkRXi
Ejm5a2+bnzrQCzBE1uSuvW0+FgarwJBZk7vOu1XjY2eNRfQqij7WqHQeUHt5F408rQAR8u6tvc2W
FUELcF2ycAI2zZW5AhnyIqrNxHPHUYBSgNZcURgLUCFvtnp/s1XbyRxL1dihsiVgb16PzrICXCqP
BOzZK4hTAS6Vz17W5mYbZTYLkAuwed1AkwtwqXx6gzY3WwKvJwyV0+6tzcyjUXp5LJUxtd7tzRaV
dyI28gIMldPurc3NVgHrCRny9KqNkArHDmvAMQoxPmIaX7UVKhwf0a9H9PUR0/iqrRtiPG50CxAL
8K5jz32ixeMFty5gkybevLRHkAIMTdLwqs374VgBtAClAL3ZylwlWRonf+1tjbGol4yah8YZ2POG
6aWV56Hx6a8Gdw07QhmMRj3f0vh0V4oybfm1IlMh8oWIrINb74xOFblk9nRIndgzMDUsSL0gOfbV
3vDgfnGwFVKQ/+JCjsm5h9Sr1ssR4fInl8zmlWSsDhVJF2TM4nL7lmD4Hp6j+G8T/gPoUqtA3BsA
AA==

--Multipart_Tue__9_Apr_2002_10:33:41_+0100_08f0c3b0--
