Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSAIRjG>; Wed, 9 Jan 2002 12:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288896AbSAIRi4>; Wed, 9 Jan 2002 12:38:56 -0500
Received: from [200.10.161.32] ([200.10.161.32]:1459 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S288845AbSAIRip>;
	Wed, 9 Jan 2002 12:38:45 -0500
Message-ID: <3C3C8093.7213A219@inti.gov.ar>
Date: Wed, 09 Jan 2002 14:40:35 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97 
 entry
In-Reply-To: <E16OLS9-0001aF-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > +               if (proc_mkdir (proc_str, 0)) {
> > +                       sprintf(proc_str, "driver/%s/%s", name,
> > card->pci_dev->slot_name);
> > +                       if (proc_mkdir (proc_str, 0)) {
> > +                               sprintf(proc_str, "driver/%s/%s/ac97", name,
> > card->pci_dev->slot_name);
> > +                               create_proc_read_entry (proc_str, 0, 0,
> > ac97_read_proc, codec);
> > +                       }
> > +               }
>
> Where do you remove it.

I don't remove it, sorry I'll add it in the next iteration of the patch
BTW: I think the entry goes away when the module is removed. Is the kernel doing
a cleanup?

> Also a card can have multiple ac97 codecs

You are right, will also take care about it. Do you think
/proc/driver/{vendor}/{dev_pci}/{num_ac97}/ac97 will be ok?

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



