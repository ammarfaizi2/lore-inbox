Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131264AbRBDA4m>; Sat, 3 Feb 2001 19:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131334AbRBDA4d>; Sat, 3 Feb 2001 19:56:33 -0500
Received: from www.inreko.ee ([195.222.18.2]:27856 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S131264AbRBDA4X>;
	Sat, 3 Feb 2001 19:56:23 -0500
Date: Sun, 4 Feb 2001 03:06:45 +0200
From: Marko Kreen <marko@l-t.ee>
To: patrick.mourlhon@wanadoo.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CDRW which doesn't work
Message-ID: <20010204030644.A23913@l-t.ee>
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org>; from patrick.mourlhon@wanadoo.fr on Sat, Feb 03, 2001 at 11:05:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 11:05:44PM +0100, patrick.mourlhon@wanadoo.fr wrote:
> Hi,
> 
> I've never could make this CDRW ATAPI to work, if someone could
> provide me any clue about the baby. I just said that people on the
> kernel mailing list may care of its but. It looks like the baby didn't
> even noticed. ;-)

Compile in options 'SCSI generic', 'SCSI cdrom and 'SCSI
emulation support' then add 'hdb=scsi' to kernel parameters.

Now you can use it as SCSI cdrom, and cd-writers recognize it
too.  Eg. for cdrecord you should probably put 'dev=0,0,0' to
command line (I assume you have no other SCSI controller).


-- 
marko

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
