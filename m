Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290461AbSAQVE7>; Thu, 17 Jan 2002 16:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290462AbSAQVEt>; Thu, 17 Jan 2002 16:04:49 -0500
Received: from [200.10.161.32] ([200.10.161.32]:10700 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S290461AbSAQVEl>;
	Thu, 17 Jan 2002 16:04:41 -0500
Message-ID: <3C473CBB.47EFBED8@inti.gov.ar>
Date: Thu, 17 Jan 2002 18:06:03 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Raul Sanchez Sanchez <raul@dif.um.es>
CC: Paul Lorenz <p1orenz@yahoo.com>, Jeremy Lumbroso <j.lumbroso@noos.fr>,
        ignacio@adesx.com, rubio@adesx.com,
        Jorge Carminati <jcarminati@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Driver via ac97 sound problem (VT82C686) Compaq Presario 700
In-Reply-To: <20020114194209.90225.qmail@web20905.mail.yahoo.com> 
		<3C4342DA.5D19601A@inti.gov.ar> <1011045793.1847.3.camel@raul> 
		<3C441F7E.FD8A345C@inti.gov.ar> <1011100904.535.2.camel@raul> 
		<3C448071.7109C9E5@inti.gov.ar> <1011137857.504.16.camel@raul> 
		<3C459995.A8EF423A@inti.gov.ar> <1011253737.502.22.camel@raul>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raul Sanchez Sanchez wrote:

>         But my question is, later i set up 1886 chip, does via inicialization
> change my configuration of it?

Try putting some printk in the function that sets the codec registers.

> If i try to print all the register of the
> 1886 in via_card_init_proc it fails :( and i can't be sure that via code
> doesn't change them.

No if the routine to write the registers isn't called *and* the initialization
doesn't reset the codec.
The first can be verified with printks, for the second examine the code. But
via_init_one is the one to check, it calls all the initializations.

> As you can see, the register are well written in ad1886, so this are my
> question,
> ---- Does via code inicialization change any value of ad1886?
> ---- Is possible that ad1886 works fine and the problem were with via
> chipset?

Jeff Garzik should know better ;-)
The only strange thing is the code is for the A version of the chip (desktop?)
and you have the B version (mobile?).
I got the 82C686A data sheet, but not the one for 82C686B.

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



