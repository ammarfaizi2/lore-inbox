Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTEDSNL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTEDSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:13:11 -0400
Received: from AMarseille-201-1-1-131.abo.wanadoo.fr ([193.252.38.131]:44841
	"EHLO gaston") by vger.kernel.org with ESMTP id S261309AbTEDSNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:13:10 -0400
Subject: Re: [PATCH] Workaround bogus CF cards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052064504.1240.12.camel@dhcp22.swansea.linux.org.uk>
References: <1052043277.4107.76.camel@gaston>
	 <1052064504.1240.12.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052068208.12384.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 May 2003 19:10:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-04 at 18:08, Alan Cox wrote:
> On Sul, 2003-05-04 at 11:14, Benjamin Herrenschmidt wrote:
> > Hi !
> > 
> > I had a problem with an "APACER" Compact Flash card. It seems that
> > beast is allergic to WIN_READ_NATIVE_MAX.
> 
> Thats probably a drive->flash check you need looking at the docs I have
> I don't see where any CF supports READ_NATIVE_MAX (of course it shouldnt
> die either)

It doesn't really die in fact, I was wrong here, but behaves a bit
strangely. I get an interrupt timeout, and a drive not ready for
command on the next command, that takes several seconds but it _seems_
it recovers.

Still, it's quite bad, so a workaround is welcome.

Ben.


