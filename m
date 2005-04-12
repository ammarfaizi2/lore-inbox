Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVDLUyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVDLUyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVDLUo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:44:26 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:20102 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S262150AbVDLUBg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:01:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
Date: Tue, 12 Apr 2005 15:01:32 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F122162@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Digi Neo 8: linux-2.6.12_r2  jsm driver
Thread-Index: AcU/kFB04+BxVSXTQMClj80c5qGQxAACWB3w
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Ihalainen Nickolay" <ihanic@dev.ehouse.ru>, <admin@list.net.ru>,
       <linux-kernel@vger.kernel.org>, "Wen Xiong" <wendyx@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's a consensus that if there's *any* choice, new /proc files as
> well as new ioctls shall not be introduced. So if there's management needed

Oh, keep in mind, the ioctls are not new.

They exist today, and are clearly defined in Documentation/ioctl-number.txt
> 'd'     F0-FF   linux/digi1.h

But we have already been down this road in a previous thread,
and I gave up on that argument as well. =)

Scott Kilau


-----Original Message-----
From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de] 
Sent: Tuesday, April 12, 2005 1:49 PM
To: Kilau, Scott
Cc: Christoph Hellwig; Ihalainen Nickolay; admin@list.net.ru; linux-kernel@vger.kernel.org; Wen Xiong
Subject: Re: Digi Neo 8: linux-2.6.12_r2 jsm driver


On Tue, 2005-04-12 11:42:31 -0500, Kilau, Scott <Scott_Kilau@digi.com>
wrote in message <335DD0B75189FB428E5C32680089FB9F12215A@mtk-sms-mail01.digi.com>:
> The JSM driver was forced to be stripped down when being submitted
> to the kernel sources, and many extended features removed as so to be
> included into the kernel, as the extended features added special ioctls
> and special /proc (/sys for 2.6) files.

There's a consensus that if there's *any* choice, new /proc files as
well as new ioctls shall not be introduced. So if there's management
needed (disclaimer: I don't own such a card), then this interface needs
to be introduced as a generic interface, which might be used by any
further drivers. We've just had this situation for some RAID cards,
where the vendor wanted to introduce a (specific for his devices)
interface. Either do it correct (as of best current practice), or don't
do it at all.

> > I didn't think that you would remove them. I read the posts and
> > wondered *why* they wanted the management pieces removed.
> > One reason to use the Digi products is for the sole fact that
> > they *can* be diagnosed.
> > I'm glad that Digi is still focused properly.
> > I agree that committing the drivers to the main kernel
> > is not the way to go if you are forced to remove dpa and ditty.

Well, again, if this features can only used by your hardware (and
there's proof that no other vendor will add these features *ever*), then
an own interface is okay. But if there's a possibility that a different
vendor *might* introduce these as well, then a generic interface needs
to be build (with first of all only one user: your driver).

> I will let the chips fall where they will, and clean up the mess that
> will soon be introduced into my driver world. =)

That's a plan. Good to head :-)

MfG, JBG

-- 
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
 fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!   O O O
ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
