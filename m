Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263151AbTCNNCi>; Fri, 14 Mar 2003 08:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263164AbTCNNCi>; Fri, 14 Mar 2003 08:02:38 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9938
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263151AbTCNNCh>; Fri, 14 Mar 2003 08:02:37 -0500
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "rain.wang" <rain.wang@mic.com.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10303140105210.9395-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10303140105210.9395-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047651707.27699.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 14:21:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 09:13, Andre Hedrick wrote:
> Rain,
> 
> The only way to deal with this is to treat the operations a failed and
> punch them back out to block for clean up.  Now we failed the a command.
> However, I think I need to set a default block hook during the reset
> process for the drive, channel, hba ... depending on the magnitude of the
> wrecking ball generated.  I need to offline Alan for this core dump.

I fixed one set of races with resets and it doesnt suprise me there is
another right now. 

