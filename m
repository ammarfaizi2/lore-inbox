Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbTCOXp7>; Sat, 15 Mar 2003 18:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbTCOXp7>; Sat, 15 Mar 2003 18:45:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7900
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261628AbTCOXp6>; Sat, 15 Mar 2003 18:45:58 -0500
Subject: Re: Any hope for ide-scsi (error handling)?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dan carpenter <d_carpenter@sbcglobal.net>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wrlk@riede.org
In-Reply-To: <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
	 <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
	 <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
	 <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047776751.1330.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Mar 2003 01:05:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 02:52, dan carpenter wrote:
> > > Here is at least one bad call to schedule() in
> > > static int idescsi_reset (Scsi_Cmnd *cmd)
> >
> > Apart from the schedule with the ide_lock held, what is that code actually
> > doing?
> >
> > 	Zwane
> 
> Hm...  Good question.  I have no idea what the while loop is for.

See 2.4.21-pre5-ac2 or later. You are discussing obsolete and known
broken code otherwise. The -ac code is closer to working and has most
but alas it seems not all the reset stuff fixed. While this works for
2.4 the 2.5 ide-scsi error handling has been rewritten by someone for
the scsi changes and so differs from both the 2.4 style scsi error
handling and reality by some margin. Once the reset code settles down
in 2.4.21-pre5-ac and 2.5.64-ac I'll take a crack at ide-scsi again.

