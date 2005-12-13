Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVLMUHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVLMUHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVLMUHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:07:16 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:57513 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751367AbVLMUHO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:07:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nHj4zad9K8kZ7Nd5npU42k9YkIpcCphEtnbVdh/9z1h5u7r1YI9OuOjYMzVzZg9qXU250U3DKe8/tCCk6EJ7Pz1/AJ7xGrPKV/EAQAt/HbyvsvQtQw+OJp97xkkJAWNIpQDuezB9aFVCtGgU2XfyhYC829WmZCAVX+GB82aQ5OU=
Message-ID: <9a8748490512131207k7637d856ved6ffb9f005849d5@mail.gmail.com>
Date: Tue, 13 Dec 2005 21:07:10 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: George Silverio da Silva <george@bbcenter.com.br>
Subject: Re: [PATCH] don't include ioctl32.h in drivers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA3MSMbDzaIk25YC/HQR9v+8KAAAAQAAAApAL0wfjPNEC+UvhsrAmwHwEAAAAA@bbcenter.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051213175930.GA17249@lst.de>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA3MSMbDzaIk25YC/HQR9v+8KAAAAQAAAApAL0wfjPNEC+UvhsrAmwHwEAAAAA@bbcenter.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, George Silverio da Silva <george@bbcenter.com.br> wrote:
> Helo guys...
>
>
>
> I'm new here...
>
> And I'm happy for this
> We need some help, and maybe we are looking in the wrong place...
>
> We are compiling the 2.6.14 Kernel for a HP Proliant DL380 G4 that has a
> Smart Array 6i Controller.
>
> We would like to know wich Kernel modules we need to add to have support for
> this controller.
>

from drivers/block/Kconfig :

config BLK_CPQ_CISS_DA
        tristate "Compaq Smart Array 5xxx support"
        depends on PCI
        help
          This is the driver for Compaq Smart Array 5xxx controllers.
          Everyone using these boards should say Y here.
          See <file:Documentation/cciss.txt> for the current list of
          boards supported by this driver, and for further information
          on the use of this driver.


> Another question: In the Slackware Distro that we have been installed, the
> system recognizes just 882Mb of Memory (The system has 2Gb)
>
Yes, you need HIGHMEM enabled to see/use all the RAM and the standard
Slackware kernel does not have HIGHMEN enabled.
That explains the 882MB of RAM.


> Will compiling Kernel 2.6.14 with this RAID support and Highmem Module
> enabled solve these problems??
>
It should.

Btw: usually a very fast way to find answers to such questions is to
"just try it" and then you'll know :-)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
