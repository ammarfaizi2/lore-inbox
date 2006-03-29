Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWC2Qmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWC2Qmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 11:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWC2Qmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 11:42:53 -0500
Received: from ic0245.upco.es ([130.206.70.245]:7606 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S1750829AbWC2Qmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 11:42:52 -0500
Date: Wed, 29 Mar 2006 18:43:30 +0200
From: Romano Giannetti <romanol@upcomillas.es>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: ALPS stop worked between 2.6.13 and 2.6.16
Message-ID: <20060329164330.GA8977@pern.dea.icai.upcomillas.es>
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
References: <20060327153624.GC8679@pern.dea.icai.upcomillas.es> <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com> <20060327190826.GA18193@pern.dea.icai.upcomillas.es> <d120d5000603271112r35ba7100jceb8aaf3e8bf8c70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d120d5000603271112r35ba7100jceb8aaf3e8bf8c70@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 27, 2006 at 02:12:26PM -0500, Dmitry Torokhov wrote:
> On 3/27/06, Romano Giannetti <romanol@upcomillas.es> wrote:
> >
> > Udev is 054 (as per Mandriva 2005). Is that the culprit?
> 
> [~/linux] grep udev Documentation/Changes
> o  udev                   071                     # udevinfo -V
> ...

Bad news... I tried to upgrade udev to 088, but evidently this is not a
trivial task. I had to reinstall back 054 to have the system working ok (I
had a bunch of 

SYS: Mar 29 18:20:11 rukbat udevsend[17819]: unable to connect to event
daemon, try to call udev directly

but then nothing happened, no devices etc. So evidently the new udev is
unable to cope with the old and maybe buggy Mandriva 2005 configuration[1]. 
I unfortunately have no time to desentangle the dependency mess, so it's
time to stop testing new kernels... unless anyone can point me to a "howto".

Thanks again for your time, 

       Romano 

[1] I have to say that udev README explixitely tell "The upstream udev
project does not support or recomend to replace a distro's udev
installation with the upstream version." So I deduce that if kernel require
udev 071, and udev do not reccomend upgrade, I am locked wiht 2.6.13 unless
I decide to upgrade to an unstable distro (current Mandriva has udev 068). 

Well, while I understand the goodness of moving things to userspace, I have
to say that this "double lock" that we have recently is mostly unfortunate. 



-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/

--
La presente comunicación tiene carácter confidencial y es para el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el destinatario indicado, le informamos que cualquier forma de distribución, reproducción o uso de esta comunicación y/o de la información contenida en la misma están estrictamente prohibidos por la ley. Si Ud. ha recibido esta comunicación por error, por favor, notifíquelo inmediatamente al remitente contestando a este mensaje y proceda a continuación a destruirlo. Gracias por su colaboración.

This communication contains confidential information. It is for the exclusive use of the intended addressee. If you are not the intended addressee, please note that any form of distribution, copying or use of this communication or the information in it is strictly prohibited by law. If you have received this communication in error, please immediately notify the sender by reply e-mail and destroy this message. Thank you for your cooperation. 
