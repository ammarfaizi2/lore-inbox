Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130400AbRBGTxn>; Wed, 7 Feb 2001 14:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbRBGTxe>; Wed, 7 Feb 2001 14:53:34 -0500
Received: from Cantor.suse.de ([213.95.15.193]:11794 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129032AbRBGTxY>;
	Wed, 7 Feb 2001 14:53:24 -0500
Date: Wed, 7 Feb 2001 20:53:22 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: changed proc permissions in 2.4
Message-ID: <20010207205322.A13246@suse.de>
In-Reply-To: <20010207204304.C457@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010207204304.C457@suse.de>; from olh@suse.de on Wed, Feb 07, 2001 at 08:43:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, Olaf Hering wrote:

> Is this the way it should be? 
> The real problem is X, it tries to open /proc/bus/pci/*/* rw, that
> fails, no devices detected. Its all on ppc, just in case that matters.

oh yeah ...

allen:~/olh # mount -oro -n -tproc none proc 
allen:~/olh # grep proc /proc/mounts 
proc /proc proc rw 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
none /root/olh/proc proc rw 0 0
allen:~/olh # cat /proc/version 
Linux version 2.4.0-4GB (root@Pentium.suse.de) (gcc version 2.95.2
19991024 (release)) #1 Wed Jan 24 15:55:09 GMT 2001


Any ideas where to look for a fix?
ppc is ro and i386 stays rw...



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
