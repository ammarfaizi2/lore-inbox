Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290190AbSALAde>; Fri, 11 Jan 2002 19:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290188AbSALAdZ>; Fri, 11 Jan 2002 19:33:25 -0500
Received: from 62-37-132-25.dialup.uni2.es ([62.37.132.25]:20608 "EHLO
	raul.dif.um.es") by vger.kernel.org with ESMTP id <S290185AbSALAdR>;
	Fri, 11 Jan 2002 19:33:17 -0500
Subject: Re: compaq presario 706 EA via 686a sound card
From: Raul Sanchez Sanchez <raul@dif.um.es>
To: salvador@inti.gov.ar
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3C3F4951.FD45C487@inti.gov.ar>
In-Reply-To: <E16P7kZ-0000A0-00@the-village.bc.nu>
	<3C3F4387.E8330684@inti.gov.ar> <3C3F46D5.3DFF5B57@inti.gov.ar> 
	<3C3F4951.FD45C487@inti.gov.ar>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Jan 2002 01:28:09 +0100
Message-Id: <1010795289.527.14.camel@raul>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:


I have insert next lines in ac97_codec.c but compiling the modules of
the kernel i have a inicialization pointer problem in {0x41445361,
"Analog Devices AD1886" , setup_ad1886} line. The code i have insert are
next lines:


	static int setup_ad1886(struct ac97_codec *codec); 

	{0x41445361, "Analog Devices AD1886" , setup_ad1886},

	/*
/* Bring up an AD1886
 */

static int setup_ad1886(struct ac97_codec * codec)
{
 /* The spec says not to mess with other bits unless
 S/PDIF is turned *off* in reg 2A */
 codec->codec_write(codec, AC97_EXTENDED_STATUS, 0);

 /* The 1886 spec dated 08/25/00 says default value=0
 but ac97 2.2 says it should be 0x2000. */
 codec->codec_write(codec, AC97_RESERVED_3A, 0x2000); /* 48 kHz */
 return 0;
 } 



i really don't know where is the problem because my acknolement? of the
kernel source is very poor :( 


thank you for your time

raul


On Fri, 2002-01-11 at 21:21, salvador wrote:
> More on the topic: That *is* AD1886 and ALSA should support it:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0107.0/0389.html
> 
> Note: I don't see EAPD control in this code, but it could explain why using ALSA
> doesn't help ;-)
> 
> SET
> 
> --
> Salvador Eduardo Tropea (SET). (Electronics Engineer)
> Visit my home page: http://welcome.to/SetSoft or
> http://www.geocities.com/SiliconValley/Vista/6552/
> Alternative e-mail: set@computer.org set@ieee.org
> Address: Curapaligue 2124, Caseros, 3 de Febrero
> Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
-----------------------------------------------
Raul Sanchez Sanchez             raul@dif.um.es
Centro de Calculo               
Facultad de Informatica    Tlf: +34 968 36 4827 
Universidad de Murcia      Fax: +34 968 36 4151
-----------------------------------------------
