Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129064AbQJaSLX>; Tue, 31 Oct 2000 13:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQJaSLM>; Tue, 31 Oct 2000 13:11:12 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:33284 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129064AbQJaSLA>; Tue, 31 Oct 2000 13:11:00 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBC8@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>, torvalds@transmeta.com
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: RE: USB init order dependencies.
Date: Tue, 31 Oct 2000 10:10:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Personally, I think this fix is less ugly than any of the 
> alternatives I've seen so far.
> 
> It removes the dependency on init order completely, by 
> statically putting 
> the hub driver into the usb_driver_list at compile time.
> 
> Leave the link ordering stuff for 2.5.

David is entitled to his opinion (IMO).
And I dislike this patch, as he and I have already discussed.

Short of fixing the link order, I like Jeff's suggestion
better (if it actually works, that is):  go back to the
way it was a few months ago by calling usb_init()
from init/main.c and making the module_init(usb_init);
in usb.c conditional (#ifdef MODULE).

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
