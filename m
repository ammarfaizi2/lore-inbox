Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSIVKCR>; Sun, 22 Sep 2002 06:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbSIVKCR>; Sun, 22 Sep 2002 06:02:17 -0400
Received: from AMarseille-201-1-5-48.abo.wanadoo.fr ([217.128.250.48]:6512
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262298AbSIVKCQ>; Sun, 22 Sep 2002 06:02:16 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
       "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE probe & waiting for busy
Date: Sun, 22 Sep 2002 11:48:34 +0200
Message-Id: <20020922100626.18852@192.168.4.1>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Ben, in fact I implemented it.  :)  I have been meaning to merge it into 
>the 2.4-ac stuff Alan/Andre are doing.

Ok, great. 

Do you actually wait for busy to go away before sending the
execute diag command ? Or do you just blast it to the device
right when entering the probe code ?

I'm concerned that if you don't wait for busy to go away, you
end up interrupting the drive reset process with execute diag.
which may not be the best thing to do...

Anyway, if you have a patch ready, pls share so I can get
that tested by the various users of those problematic
setups !

Thanks,
Ben.



