Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbQKGIqZ>; Tue, 7 Nov 2000 03:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130303AbQKGIqP>; Tue, 7 Nov 2000 03:46:15 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:1481 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130289AbQKGIqD>; Tue, 7 Nov 2000 03:46:03 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 08:44:22 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011062354.eA6NsT705093@sleipnir.valparaiso.cl>
In-Reply-To: <200011062354.eA6NsT705093@sleipnir.valparaiso.cl>
MIME-Version: 1.0
Message-Id: <00110708454001.01218@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, Horst von Brand wrote:
> "James A. Sutherland" <jas88@cam.ac.uk> said:
> > On Mon, 06 Nov 2000, Horst von Brand wrote:
> 
> [...]
> 
> > > The problem (AFAIU) is that if the levels aren't set on startup, they are
> > > random in some cases.
> 
> > So set them on startup. NOT when the driver is first loaded. Put it in
> > the rc.d scripts.
> 
> There is a noticeable delay between to moment the module is insmod(8)ed,
> and the moment when its settings are set by the startup script. Not funny
> if it is going full blast ATM.

Yes, I know. That's why the driver MUST NOT change the volume settings when
insmod(8)ed, waiting instead until it gets specific settings from the script,
at which point it can initialise the card to the correct settings without a
delay.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
