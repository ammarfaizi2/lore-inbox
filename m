Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVH3IlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVH3IlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVH3IlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:41:14 -0400
Received: from mail.pds.de ([195.243.202.97]:58378 "EHLO mail.pds.de")
	by vger.kernel.org with ESMTP id S1751237AbVH3IlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:41:14 -0400
From: "Thomas Pfeiffer" <pfeiffer@pds.de>
Organization: PDS GmbH
To: Alexey Dobriyan <adobriyan@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>
Date: Tue, 30 Aug 2005 10:42:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] isdn_v110 warning fix
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de
Message-ID: <4314380C.31589.937925@localhost>
In-reply-to: <20050830082033.GB12449@mipter.zuzino.mipt.ru>
References: <200508300105.44247.jesper.juhl@gmail.com>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-15; AVE: 6.31.1.0; VDF: 6.31.1.192; host: mail)
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 30, 2005 at 01:05:43AM +0200, Jesper Juhl wrote:
> > drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function
> 
> > --- linux-2.6.13-orig/drivers/isdn/i4l/isdn_v110.c
> > +++ linux-2.6.13/drivers/isdn/i4l/isdn_v110.c
> > @@ -516,11 +516,11 @@
> 
> > -isdn_v110_stat_callback(int idx, isdn_ctrl * c)
> > +isdn_v110_stat_callback(int idx, isdn_ctrl *c)
> >  {
> >  	isdn_v110_stream *v = NULL;
> >  	int i;
> > -	int ret;
> > +	int ret = 0;
> 
> ret is used only in isdn_v110_stat_callback()::case ISDN_STAT_BSENT.
> It's possible for it to be unused only if passed c->parm.length is 0.
> Do you see codepaths that can do it?
> 
initializing ret with the value zero is correct and should be 
done.




---------------------------------------------------
Thomas Pfeiffer, PDS - Programm + Datenservice GmbH
email: pfeiffer@pds.de, http://www.pds.de/QFS-BILD
Tel: (49) 4261 855 614, Fax: (49) 4261 855 675

