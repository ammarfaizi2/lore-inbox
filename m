Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132801AbRDZPnr>; Thu, 26 Apr 2001 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132767AbRDZPng>; Thu, 26 Apr 2001 11:43:36 -0400
Received: from [195.6.125.97] ([195.6.125.97]:14095 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S131472AbRDZPna>;
	Thu, 26 Apr 2001 11:43:30 -0400
Date: Thu, 26 Apr 2001 17:40:57 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: Eric PENNAMEN <pennamen@caramail.com>
Cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: Fw: where can I find the IP address ?
Message-Id: <20010426174057.230044fd.sebastien.person@sycomore.fr>
In-Reply-To: <988309323021359@caramail.com>
In-Reply-To: <988309323021359@caramail.com>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 26 Apr 2001 17:22:03 GMT+1
Eric PENNAMEN <pennamen@caramail.com> à écrit :

> Je ne suis pas un expert Linux et je ne pourrais peut etre pas 
> t'aider mais je le probleme n'es-t pas tres clair :
> Est il de recuperer l'adresse IP du poste (transfert de donne entre le script
> et le driver au chargement) ?
> ou bien que le driver doit ouvrir dans le kernel une socket a l'adresse IP donne dans le script 
> et que tu ne sais pas comment faire ?

en fait mon driver commande une sorte de carte réseau dont l'ip est attribué dans un script,
le but est de recuperer l'ip attribuée. je crois que ca correspond plus a ta première proposition

mais effectivement j'ai bien quelques idées mais elles n'ont abouti a rien (appel ioctl, 
utiliser la structure device qui doit contenir l'adresse du protocol utilisé dev->pa_addr [
malheureusement je me fais jeter à la compil car ce champs n'existerait pas ... a til disparu depuis
les noyaux 2.2.14 ??])

pourtant c'est ce que preconise le bouquin de rubini (edition 1)

voila si t'as une piste ...

merci

> 
> 
> 
> sébastien person a écrit :
> 
>  Début du message transféré :
> 
>  Date: Wed, 25 Apr 2001 16:45:48 +0200
>  From: sébastien person <sebastien.person@sycomore.fr>
>  To: Helge Hafting <helgehaf@idb.hist.no>
>  Subject: Re: Fw: where can I find the IP address ?
> 
>  Le Wed, 25 Apr 2001 15:17:59 +0200
>  Helge Hafting <helgehaf@idb.hist.no> à écrit :
> 
>  > sébastien person wrote:
>  > >
>  > > Début du message transféré :
>  > >
>  > > Date: Tue, 24 Apr 2001 16:43:18 +0200
>  > > From: sébastien person <sebastien.person@sycomore.fr>
>  > > To: liste noyau linux <linux-kernel@vger.kernel.org>
>  > > Subject: where can I find the IP address ?
>  > >
>  > > I'm dealing with a driver wich need the IP address for specifics using.
>  > >
>  > The IP address of what?
>  > Rememeber, a computer can have an arbitrary number of different
>  > IP addresses assigned to various interfaces. It may even have
>  > several IP addresses on the same network card.
>  >
>  > So, which of them do you want?
>  >
>  > Helge Hafting
> 
>  Yes that's right. In fact (excuse my bad english), my driver is 'iconfiged- up' with an
>  IP in a script, and there is only one IP attach to the adapter. The adapter is a serial
>  modem wich will work like an ethernet card, I'm working on the encapsulation of packets
>  on the serial line and I need the IP that ifconfig attach to it.
> 
>  I've seen in the rubini linux device driver that it exists one field in the struture
>  that contain the IP but it doesn't exist in my structure so I though that I can find it
>  elsewhere. So the IP that I need for the driver of the device, is the one the device is
>  attached to. I expect to explain myself clearly else don't hesitate to tell me more.
> 
>  thanks
> 
>  sebastien person
> 
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at http://www.tux.org/lkml/
> ______________________________________________________
> Boîte aux lettres - Caramail - http://www.caramail.com
> 
> 
