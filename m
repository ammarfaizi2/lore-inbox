Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQKFRNY>; Mon, 6 Nov 2000 12:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQKFRNO>; Mon, 6 Nov 2000 12:13:14 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:49650 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129061AbQKFRM4>;
	Mon, 6 Nov 2000 12:12:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <00110617033201.01646@dax.joh.cam.ac.uk> 
In-Reply-To: <00110617033201.01646@dax.joh.cam.ac.uk>  <200011061657.eA6Gv0w08964@pincoya.inf.utfsm.cl> 
To: "James A. Sutherland" <jas88@cam.ac.uk>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 17:12:16 +0000
Message-ID: <7101.973530736@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jas88@cam.ac.uk said:
>  So set them on startup. NOT when the driver is first loaded. Put it
> in the rc.d scripts. 

No. You should initialise the hardware completely when the driver is 
reloaded. Although the expected case is that the levels just happen to be 
the same as the last time the module was loaded, you can't know that the 
machine hasn't been suspended and resumed since then.


jas88@cam.ac.uk said:
>  No need. Let userspace save it somewhere, if that's needed. 

Don't troll, James. Reread the thread and see why doing it in userspace is 
too late.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
