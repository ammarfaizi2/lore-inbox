Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132028AbRAQJ4J>; Wed, 17 Jan 2001 04:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132006AbRAQJz6>; Wed, 17 Jan 2001 04:55:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22024 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131620AbRAQJzm>;
	Wed, 17 Jan 2001 04:55:42 -0500
Message-ID: <3A656C09.4A40BBF5@mandrakesoft.com>
Date: Wed, 17 Jan 2001 04:55:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Andreas Dilger <adilger@turbolinux.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Bryan Henderson'" <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <200101162111.f0GLBNb14141@webber.adilger.net> <20276.979724327@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> adilger@turbolinux.com said:
> >  One reason why this may NOT ever make it into the kernel is that I
> > know "kernel poking at devices" is really frowned upon.
> 
> A possible alternative is to specify drives by serial number.

Currently mount(8) supports mounting by '-L <label>' and '-U <UUID>'. 
Most modern mke2fs proggies will assign a UUID to each newly created
filesystem.  For /etc/fstab, you can specify LABEL=xxx or UUID=xxx
instead of a device name.

The one thing I don't know is... can the kernel mount the root fs if
only given the uuid?

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
