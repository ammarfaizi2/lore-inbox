Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbTHVDWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 23:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbTHVDWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 23:22:40 -0400
Received: from [202.107.117.26] ([202.107.117.26]:42458 "EHLO ldap")
	by vger.kernel.org with ESMTP id S262997AbTHVDWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 23:22:37 -0400
Date: Fri, 22 Aug 2003 11:22:30 +0800
From: "Bill J.Xu" <xujz@neusoft.com>
Subject: Re: "ctrl+c" disabled!
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <053301c3685c$9ea6fe50$2a01010a@avwindows>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Mailer: Microsoft Outlook Express 6.00.3790.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <036601c367e0$01adabc0$2a01010a@avwindows>
 <3F457A19.8E8A1F65@gmx.de> <04b901c36852$dccc7660$2a01010a@avwindows>
 <3F45830A.5C0F5BCA@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after run od -tx1, the following is the result
------------------------------------------------
bash-2.05# ./od -tx1
0000000
------------------------------------------------
and I use "killall xxx_appname" to kill the progress after telnet the linux box.




----- Original Message ----- 
From: "Edgar Toernig" <froese@gmx.de>
To: "Bill J.Xu" <xujz@neusoft.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, August 22, 2003 10:42 AM
Subject: Re: "ctrl+c" disabled!


> "Bill J.Xu" wrote:
> > 
> > The following is the stty' result, I think it's right
> > ----------------------------------------------------------------------------------
> > bash-2.05# stty -a
> > speed 9600 baud; rows 0; columns 0; line = 0;
> > intr = ^C; quit = ^\; erase = ^?; kill = ^X; eof = ^D; eol = <undef>;
> > eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
> > lnext = ^V; flush = ^U; min = 1; time = 0;
> > -parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
> > -ignbrk -brkint ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
> > -iuclc ixany -imaxbel
> > opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
> > isig icanon -iexten echo -echoe -echok -echonl -noflsh -xcase -tostop echoprt
> > echoctl echoke
> > ----------------------------------------------------------------------------------
> > but  ^C is bad
> 
> Hmm... looks fine.  intr set to ^C and isig enabled.  Maybe you should check what
> the terminal program is actually sending:
> 
>   od -tx1
> 
> Then type Ctrl-C Ctrl-D.  Should print "00000000 03".
> 
> How do you kill the process from telnet?  kill -9 <pid> or kill -2 <pid>?
> Maybe sigint is ignored (possible if bash was started with ignored sigint -
> broken/strange getty).  Is job control (^Z/fg) working?
> 
> Ciao, ET.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
