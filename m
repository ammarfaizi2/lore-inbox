Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161205AbWJ3KM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWJ3KM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161206AbWJ3KM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:12:26 -0500
Received: from ms-smtp-03.ohiordc.rr.com ([65.24.5.137]:33672 "EHLO
	ms-smtp-03.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S1161205AbWJ3KMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:12:25 -0500
Date: Mon, 30 Oct 2006 05:12:02 -0500
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Oliver Neukum <oliver@neukum.name>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Fwd: Re: [linux-usb-devel] usb initialization order (usbhid	vs. appletouch)
Message-ID: <20061030101202.GB9265@nineveh.rivenstone.net>
Mail-Followup-To: Soeren Sonnenburg <kernel@nn7.de>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Oliver Neukum <oliver@neukum.name>, Sergey Vlasov <vsu@altlinux.ru>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <1161856438.5214.2.camel@no.intranet.wo.rk> <1162054576.3769.15.camel@localhost> <200610282043.59106.oliver@neukum.org> <200610282055.29423.oliver@neukum.name> <1162067266.4044.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162067266.4044.2.camel@localhost>
User-Agent: Mutt/1.5.12-2006-07-14
From: jhf@columbus.rr.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 10:27:46PM +0200, Soeren Sonnenburg wrote:
> On Sat, 2006-10-28 at 20:55 +0200, Oliver Neukum wrote:
> > > From: Sergey Vlasov <vsu@altlinux.ru>
> > > Subject: usbhid: Add HID_QUIRK_IGNORE_MOUSE flag
> > >
> > > Some HID devices by Apple have both keyboard and mouse interfaces; the
> > > keyboard interface is handled by usbhid, but the mouse (really
> > > touchpad) interface must be handled by the separate 'appletouch'
> > > driver.  Using HID_QUIRK_IGNORE will make hiddev ignore both
> > > interfaces, therefore a new quirk flag to ignore only the mouse
> > > interface is required.

    The appletouch driver doesn't work properly on the MacBook
(non-Pro).  It claims the device, and sort of functions, but is
basically unusable.

    If this goes in, and blacklists the MacBook touchpad too, Macbook
users will be unhappy.  I think the MacBook and the -Pro use the same
IDs, though, which makes a problem for this patch until appletouch is
fixed on MacBooks.

> > Exactly. Combing both patches:
> > Soeren, if this works, please sign it off and send it to Greg.
>
> OK, this works, but as the same IDs need the FN key hacks I or'ed the FN
> and mouse quirk flags. Also I added the appleir (builtin infrared on the
> macbook/pro) to the list of ignored IDs. Therefore the patch though very
> similar is again slightly different.
>
> But hey, it worked for me over the last hour on this mbp :-))
> Please comment/apply.
>
> Soeren.

> Signed-off-by: Soeren Sonnenburg <kernel@nn7.de>
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


--
Joseph Fannin
jfannin@gmail.com

