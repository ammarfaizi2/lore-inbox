Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288950AbSBDMnR>; Mon, 4 Feb 2002 07:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288953AbSBDMnH>; Mon, 4 Feb 2002 07:43:07 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:45329 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S288950AbSBDMmz>; Mon, 4 Feb 2002 07:42:55 -0500
Date: Mon, 4 Feb 2002 23:43:45 +1100
From: john slee <indigoid@higherplane.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, dank@kegel.org
Subject: Re: Asynchronous CDROM Events in Userland
Message-ID: <20020204124344.GA4757@higherplane.net>
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <a3l4uc$laf$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3l4uc$laf$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ added dan to cc list ]

On Sun, Feb 03, 2002 at 09:07:24PM -0800, H. Peter Anvin wrote:
> > If not what do you guys think about extensions to the cdrom drivers to
> > handle these types of things?
> > 
> 
> Rather than a signal, it should be a file descriptor of some sort, so
> one can select() etc on it.  Personally I can't imagine polling would
> take any appreciable amount of resources, though.
> 
> A more important issue is probably to get notification when the eject
> button is pushed and the device is locked, so that it can try to
> umount and eject it, unless busy.

not so long ago dan kegel suggested an interface to signals based on
file descriptors, and perhaps even an alpha patch implementing such.
this allowed you to select() on them.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99356014431024&w=2

of particular interest is this quote from dan's fantasy manpage:

> HISTORY
>      sigopen() first appeared in the 2.5.2 Linux kernel.

a bit late, but an uncanny prediction.
dan, are you nostradamus ? :-)

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
