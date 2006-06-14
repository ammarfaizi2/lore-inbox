Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWFNPWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWFNPWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWFNPWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:22:34 -0400
Received: from web26012.mail.ukl.yahoo.com ([217.146.177.34]:10602 "HELO
	web26012.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964996AbWFNPWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:22:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=djivO2IQfcXTVd265dAIz7Ssu/sQ5juuJdLb1a6C/qarG82psb7ZdId0LbT7YlFiP7jTIFmXleRPL66dZYmdS7XR4XfsGAFbS6Ws++qdZuZZNie7iDElFTJQ5JLj9TxaEohKEaQkXxUoeBAKINsz/Rj4f4/Cw3vjQ+u+hiYh63o=  ;
Message-ID: <20060614152232.17933.qmail@web26012.mail.ukl.yahoo.com>
Date: Wed, 14 Jun 2006 17:22:32 +0200 (CEST)
From: =?iso-8859-1?q?Pablo=20Barb=E1chano?= <pablobarbachano@yahoo.es>
Subject: Re: loop devices removable
To: 7eggert@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <E1FqWt5-0001Ro-8q@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 --- Bodo Eggert <7eggert@elstempel.de> escribió:

> Pablo Barbachano <pablobarbachano@yahoo.es> wrote:
> 
> [loop devices]
> 
> > The (probably broken) reason I want to do that is so I can use (my
> > modified) pmount to mount them.
> 
> I'm wondering if fuse would be suited better. I did not yet experiment
> with that, but it seems it has everything you need.

There is something based on FUSE:
http://lwn.net/Articles/173617/

Which involves UML... doesn't seem a good option to me...

My approach is simpler:
1. Change pmount so it supports loopback devices
2. Change the /dev/loop* group permissions.

You can accomplish 2 by modifying udev rules, the kernel or chgrp directly.
I just wondered if the kernel how the kernel could be changed and why it wouldn't be a good idea.

Cheers,
Pablo

> -- 
> Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
> verbreiteten Lügen zu sabotieren.
> 
> http://david.woodhou.se/why-not-spf.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


__________________________________________________
Correo Yahoo!
Espacio para todos tus mensajes, antivirus y antispam ¡gratis! 
Regístrate ya - http://correo.yahoo.es 
