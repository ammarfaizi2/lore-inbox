Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGIuk>; Wed, 7 Feb 2001 03:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRBGIuV>; Wed, 7 Feb 2001 03:50:21 -0500
Received: from [216.161.55.93] ([216.161.55.93]:18680 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129028AbRBGIuL>;
	Wed, 7 Feb 2001 03:50:11 -0500
Date: Wed, 7 Feb 2001 00:51:26 -0800
From: Greg KH <greg@wirex.com>
To: Eric Sandeen <sandeen@sgi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] updates for KLSI usb->ethernet
Message-ID: <20010207005126.A32480@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Eric Sandeen <sandeen@sgi.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3A80ED7C.F3A92D5@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A80ED7C.F3A92D5@sgi.com>; from sandeen@sgi.com on Wed, Feb 07, 2001 at 12:38:52AM -0600
X-Operating-System: Linux 2.2.18-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 12:38:52AM -0600, Eric Sandeen wrote:
> Any thoughts on what would be more correct, 
> 
> a) device descriptor silently changes
> b) device magically disconnects/reconnects on its own
> 
> Both seem a bit odd, but take your pick.  :)

b) is more like other devices.  They use 1 descriptor id for the "I have
no firmware" state, then after firmware is downloaded, they disconnect,
and reconnect with a new id which means they have the firmware loaded.

Lots of usb-serial devices do this, and so does just about any
Anchor/Cypress EZ-USB chip based design.

Silently changing descriptor ids while connected is just asking for
trouble :)

You also might want to post this to linux-usb-devel as that's where the
authors of this driver are known to hang out.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
