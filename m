Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbTHVCMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 22:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTHVCMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 22:12:45 -0400
Received: from [202.107.117.26] ([202.107.117.26]:57815 "EHLO ldap")
	by vger.kernel.org with ESMTP id S262983AbTHVCMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 22:12:44 -0400
Date: Fri, 22 Aug 2003 10:12:39 +0800
From: "Bill J.Xu" <xujz@neusoft.com>
Subject: Re: "ctrl+c" disabled!
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <04b901c36852$dccc7660$2a01010a@avwindows>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Mailer: Microsoft Outlook Express 6.00.3790.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <036601c367e0$01adabc0$2a01010a@avwindows>
 <3F457A19.8E8A1F65@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the stty' result, I think it's right
----------------------------------------------------------------------------------
bash-2.05# stty -a
speed 9600 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^X; eof = ^D; eol = <undef>;
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
lnext = ^V; flush = ^U; min = 1; time = 0;
-parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
-ignbrk -brkint ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
-iuclc ixany -imaxbel
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon -iexten echo -echoe -echok -echonl -noflsh -xcase -tostop echoprt
echoctl echoke
----------------------------------------------------------------------------------
but  ^C is bad

----- Original Message ----- 
From: "Edgar Toernig" <froese@gmx.de>
To: "Bill J.Xu" <xujz@neusoft.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, August 22, 2003 10:04 AM
Subject: Re: "ctrl+c" disabled!


> "Bill J.Xu" wrote:
> >
> > when I connect linux through serial port,and run a program such
> > as "ping xxx.xxx.xxx.xxx",then I can not stop it by using "ctrl+c".
> > and the only way is to telnet it,and kill that progress
> > 
> > why?
> 
> Try:
> 
>   stty -a
> 
> and check the intr setting.  Maybe it's set to DEL (^?).
> You can correct it with:
> 
>   stty intr "^c"
> 
> Ciao, ET.
> 
