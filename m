Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbQKRI0y>; Sat, 18 Nov 2000 03:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbQKRI0o>; Sat, 18 Nov 2000 03:26:44 -0500
Received: from [216.161.55.93] ([216.161.55.93]:35830 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131508AbQKRI0d>;
	Sat, 18 Nov 2000 03:26:33 -0500
Date: Fri, 17 Nov 2000 23:56:24 -0800
From: Greg KH <greg@wirex.com>
To: Ben Ford <bford@talontech.com>
Cc: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6 still very broken
Message-ID: <20001117235624.B26341@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Ben Ford <bford@talontech.com>,
	David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <8v4306$sga$1@cesium.transmeta.com> <3A161337.6A1BE826@linux.com> <20001117223137.A26341@wirex.com> <3A162EFE.A980A941@talontech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A162EFE.A980A941@talontech.com>; from bford@talontech.com on Fri, Nov 17, 2000 at 11:25:50PM -0800
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 11:25:50PM -0800, Ben Ford wrote:
> Here is lspci output from the laptop in question.  Is this not UHCI?

Yes it is.  Just a bit funny if you think about it, but with Intel and
Via putting the UHCI core into their chipsets I guess it makes sense.

One note for the archives, if you are presented a choice between a OHCI
or a UHCI controller, go for the OHCI.  It has a "cleaner" interface,
handles more of the logic in the silicon, and due to this provides
faster transfers.

In it's defense, the UHCI design was the first one, and OHCI
capitalized on that by fixing some of its weaknesses.  Hopefully the
same thing will not happen for USB 2.0, and everyone will like EHCI.


greg k-h
(who has UHCI in all of his machines except one.)

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
