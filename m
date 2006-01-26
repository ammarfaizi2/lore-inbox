Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWAZC0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWAZC0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWAZC0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:26:36 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:23918 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751249AbWAZC0g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:26:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FE91HQsFbUVckx7/ATxnF/VXcbL2MFK4CMeV5j34Og0tsjAyImTWxJ+7BoypuxYjjrGVC9waeIZlHpEQk5aD2pkVA8gNKI6hHwI6/qFob8GSSZYNXCKHq8OxZSUrKknjFOzJdyChz51zTC9Clh5lKhRybjQVczb38SknPk+MJiI=
Message-ID: <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
Date: Wed, 25 Jan 2006 21:26:35 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <43D7A7F4.nailDE92K7TJI@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Albert Cahalan <acahalan@gmail.com> wrote:

> > BTW, before Joerg mentions portability, I'd like to remind
> > everyone that all modern OSes support the use of normal device
> > names for SCSI. The most awkward is FreeBSD, where you have
> > to do a syscall or two to translate the name to Joerg's very
> > non-hotplug non-iSCSI way of thinking. Windows, MacOS X, and
> > even Solaris all manage to handle device names just fine. In
> > numerous cases, not just Linux, cdrecord is inventing crap out
> > of thin air to satisfy a pre-hotplug worldview.
>
> Looks like you are badly informed, so I encourage you to get yourself informed
> properly before sending your next postig....
>
> libscg includes 22 different SCSI low level transport implementations.
>
> -       Only 5 of them allow a /dev/hd* device name related access.
>
> -       11 of them use file descriptors as handles for sending SCSI
>         commands but do not have a name <-> fs relation and thus
>         _need_ a SCSI device naming scheme as libscg offers.
>         This is because there is no 1:1 relation between SCSI addressing
>         and a fd retrieved from a /dev/* entry.
>
> -       6 of them not even allow to get a file descriptors as handles for
>         sending SCSI commands. These platforms of course need the SCSI device
>         naming scheme as libscg offers.
>
> Conclusion:
>
> 17 Platforms _need_ the addressing scheme libscg offers
>
> 5  Platforms _may_ use a different access method too.
>
> NOTE: Amongst the 6 plaforms that do not allow to even get a file descriptor
> there is a modern OS like MacOS X

You can't fool me, because I looked at the cdrecord source
code and at the documented APIs for various OSes.

It's misleading to say that MacOS doesn't allow a file
descriptor. MacOS has something similar to what Linux
has, but not in the normal filesystem namespace. You
specify a name to get a handle. Of course, on MacOS,
Joerg also uses -scanbus to create nonsense.

Names can be handled by Windows, FreeBSD, MacOS X,
Linux, OpenBSD, Solaris, HP-UX, AIX, and IRIX.
That's everything that isn't end-of-lifed.

The rest of your 22 platforms are dead and dying things
that are unlikely to be upgrading to the latest software or
hardware, assuming they survived the Y2K bug. It's old
stuff like the Amiga, the NeXT, etc.

Using numbers for CD burners is like trying to send email
to the IP address of the recipient, which half-way worked
until DHCP was invented. Wait, we could have all email
clients offer a -scannet option. :-)
