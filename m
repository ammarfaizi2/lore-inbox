Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTKIRjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTKIRjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:39:11 -0500
Received: from lilzmailfe01.liwest.at ([212.33.55.13]:10028 "EHLO
	lilzmailfe01.liwest.at") by vger.kernel.org with ESMTP
	id S262714AbTKIRjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:39:08 -0500
Message-ID: <3FAE7BB1.3090007@voxel.at>
Date: Sun, 09 Nov 2003 18:38:57 +0100
From: "Dr. Simon Vogl" <office@voxel.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sensors@stimpy.netroedge.com
CC: DI Dr Simon Vogl <simon@voxel.at>, linux-kernel@vger.kernel.org
Subject: Re: I2C parallel port adapters drivers
References: <20031102132342.79920c6f.khali@linux-fr.org>	<3FAB6A8C.9070608@voxel.at> <20031107223611.173c82cc.khali@linux-fr.org>
In-Reply-To: <20031107223611.173c82cc.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,
some comments, in no particular order :)

When I wrote the parallel port drivers, the parport api was changing a 
lot. Therefore I did not
make use of it. Blocking the parport might be a good idea, but it 
introduces another dependency.

Anyway, parport only makes real sense when you want to share your 
parport between multiple devices,
say a zip drive. Therefore, a question to the whole sensors list: Is 
anyone really using such a setup?
It should be at least be configurable as an option (also think of using 
it in embedded devices, where you
wouldn't want to bloat the kernel with such things...)

Also, are there any hardware cracks out there with multiple adapters, 
like a home-brew philips adapter
and a velleman kit on two parports?

Just a few special cases to think about...

As for the naming, i2c-parport would conflict with the old i2c-parport 
module that is still available in 2.4ish
kernels in the v4l section - maybe i2c-parallel is an option.

Also, have a look at the wealth of i2c drivers that are present in the 
2.6 kernels :)
So long,
Simon

Jean Delvare wrote:

>OK, I'll write a unified driver then. Just one more question. Any reason
>to prefer direct I/O access (ELV/Velleman) over parallel-port-style
>programming (i2c-philips-par)? I'd say that the second is preferable,
>but you might have had a reason to use direct access, that I ignore. If
>not, I'll somehow use i2c-philips-par as a base for my unified driver,
>which I'll probably call i2c-parport (since it won't be Philips-specific
>anymore). That driver would support Philips adapters, ELV, Velleman and
>ADM evaluation boards (I have one here for testing).
>
>Thanks a lot for spending some time replying.
>
>  
>


-- 
Dipl.-Ing. Dr. Simon Vogl !  http://www.voxel.at/
VoXel Interaction Design  !  office@voxel.at
Breitwiesergutstr. 50     !  +43 650 2323 555
A-4020 Linz - Austria     !  





