Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbUJ0RRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbUJ0RRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbUJ0RQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:16:34 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:41348 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262516AbUJ0RJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:09:05 -0400
Date: Wed, 27 Oct 2004 19:08:56 +0200
To: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Message-ID: <20041027170856.GB12538@gamma.logic.tuwien.ac.at>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <20041027153715.GB13991@kroah.com> <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <1098890583.6990.20.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041027153715.GB13991@kroah.com> <1098890583.6990.20.camel@laptop.fenrus.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Mit, 27 Okt 2004, Arjan van de Ven wrote:
> > for class_simple_* makes the nvidia module useless as it uses several:
>
> is this the module as downloaded from nvidia, or as hacked by some
> distro ?
> 

On Mit, 27 Okt 2004, Greg KH wrote:
> I think these changes are only in the Gentoo modified version of the
> driver, right?  I don't think that nvidia wrote the driver that way.

Yes they did. I downloaded the original NVIDIA-Linux-x86-1.0-6111-pkg1.run,
extracted the source and found in nv.c many things like:
#ifdef NV_CLASS_SIMPLE_PRESENT
    class_simple_device_remove(MKDEV(NV_MAJOR_DEVICE_NUMBER, 255));
    for (i = 0; i < num_nv_devices; i++)
        class_simple_device_remove(MKDEV(NV_MAJOR_DEVICE_NUMBER, i));
    class_simple_destroy(class_nvidia);
#endif

and in conftest.sh the check for class_simple_present by checking for
struct class_simple.

> > I don't want to start a flame war and long discussion, just want to ask
> > wether this change (to _GPL) was intended,
> 
> Yes it was.

Ok. I can live with that.

> > and if yes, if there is a way to fix nvidia kernel modules (or others)
> > using this device management interface.
> 
> Get them to change the license on their code.

Well, funny answer, but not useful for now.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
BERY POMEROY
1. The shape of a gourmet's lips. 2. The droplet of saliva which hangs
   from them.
			--- Douglas Adams, The Meaning of Liff
