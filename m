Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273983AbRISK2a>; Wed, 19 Sep 2001 06:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273235AbRISK2U>; Wed, 19 Sep 2001 06:28:20 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:32706 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S273983AbRISK2H>; Wed, 19 Sep 2001 06:28:07 -0400
Message-ID: <3BA8726F.CC5FA2AD@rcn.com.hk>
Date: Wed, 19 Sep 2001 18:24:47 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [zh_TW] (X11; U; Linux 2.4.4-1DC i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: EFAULT from file read.
In-Reply-To: <Pine.GSO.4.21.0109180900320.25323-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro ¼g¹D¡G
> 
> On Tue, 18 Sep 2001, Richard B. Johnson wrote:
> 
> > File I/O requires a process context. Your file descriptor means
> > nothing unless associated with the process that opened the file.
> 
> It fscking doesn't.  He had clearly said that he calls file->f_op->read(),
> which has nothing whatsofuckingever to descriptors.  Sod off and don't
> return until you learn to read.
> 
> As for the original question - grep fro set_fs and you'll see what to
> do (basically, set_fs(KERNEL_DS) before the call of ->read() and restore
> afterwards).

Problem solved by calling dummy=set_fs(KERNEL_DS) . But remember to call
set_fs(dummy) to restore after the read.

regards,

David
