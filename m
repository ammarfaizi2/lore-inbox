Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTKQSvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTKQSvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:51:13 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:13575 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263583AbTKQSvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:51:10 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: viro@parcelfarce.linux.theplanet.co.uk,
       Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: Is initramfs freed after kernel is booted?
Date: Mon, 17 Nov 2003 21:33:59 +0300
User-Agent: KMail/1.5.3
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB90A6A.4050505@nortelnetworks.com> <20031117180312.GZ24159@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031117180312.GZ24159@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311172133.59839.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 November 2003 21:03, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
> On Mon, Nov 17, 2003 at 12:50:34PM -0500, Chris Friesen wrote:
> > viro@parcelfarce.linux.theplanet.co.uk wrote:
> > >On Mon, Nov 17, 2003 at 11:06:48AM -0500, Chris Friesen wrote:
> > >>Anyone know why it overmounts rather than pivots?
> > >
> > >Because amount of extra code you lose that way takes more memory than
> > >empty roots takes.
> > >
> > >Remove whatever files you don't need and be done with that.
> >
> > How do you remove files from the old rootfs after the new one has been
> > mounted on top of it?
>
> You do that before ;-)

would the following work?

pivot_root . /initramfs
cd /initramfs && rm -rf *

?? doing it before is rather hard ... you apparently still need something to 
execute your mounts :)

-andrey 

