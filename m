Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRAGRxw>; Sun, 7 Jan 2001 12:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbRAGRxn>; Sun, 7 Jan 2001 12:53:43 -0500
Received: from enst.enst.fr ([137.194.2.16]:53468 "HELO enst.enst.fr")
	by vger.kernel.org with SMTP id <S130069AbRAGRx1>;
	Sun, 7 Jan 2001 12:53:27 -0500
Date: Sun, 7 Jan 2001 18:53:23 +0100
From: Nicolas Mailhot <Nicolas.Mailhot@email.enst.fr>
To: Greg KH <greg@kroah.com>
Cc: Nicolas Mailhot <Nicolas.Mailhot@email.enstfr.redhat.com>,
        mdharm-usb@one-eyed-alien.net, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, jerdfelt@valinux.com
Subject: Re: [Patch] [linux-2.4.0] drivers/usb/Config.in
Message-ID: <20010107185323.A913@rousalka.maisel2.rezel.enst.fr>
In-Reply-To: <20010107140440.E1468@rousalka.maisel2.rezel.enst.fr> <20010107093711.A2748@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010107093711.A2748@wirex.com>; from greg@kroah.com on dim, jan 07, 2001 at 18:37:11 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le dim, 07 jan 2001 18:37:11, Greg KH a écrit :
> On Sun, Jan 07, 2001 at 02:04:40PM +0100, Nicolas Mailhot wrote:

> >  Here is a patchlet to stop people searching for the
> > mysteriously hidden USB Mass Storage driver (in case they
> > didn't make the connection with SCSI at once like me).
> 
> I wouldn't recommend this one.  If you do this, should we do the same
> for all of the other dependencies in the USB config section?  Like
> VIDEO, SOUND, and others?  That would make for a _big_ mess.

Well, it's certainly not the first patch of this kind to
make it into the USB config file (see input core), so if a
precedant was set, it wasn't by this patch. Do we need to do
this for every dependency ? I don't know, IMHO only for the
non obvious ones (and anyway, that's just a bit of
documentation, what's wrong with having more doc ?)

And the dependency between USB Mass Storage and SCSI support
is more than sufficiently obscure for the end-user to
justify this one. Comme on, who -- appart from the driver
developpers -- would think of it at once by itself ? I do
know I spent almost more time searching for the Mass Storage
driver option than writing/testing this patch, since I've
got a SCSI-less system.

Knowing that something requires VIDEO or SOUND, on the other
hand, do not requires deep knowledge of the driver sources.

Regards,

-- 
Nicolas Mailhot

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
