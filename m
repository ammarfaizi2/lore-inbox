Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTIAHAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbTIAHAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:00:42 -0400
Received: from [202.107.117.26] ([202.107.117.26]:40116 "EHLO ldap")
	by vger.kernel.org with ESMTP id S262657AbTIAHAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:00:41 -0400
Date: Mon, 01 Sep 2003 12:50:25 +0800
From: "Bill J.Xu" <xujz@neusoft.com>
Subject: Re: "ctrl+c" disabled!
To: Edgar Toernig <froese@gmx.de>, root@chaos.analogic.com,
       rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-id: <002101c37044$8f49eea0$2a01010a@avwindows>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Mailer: Microsoft Outlook Express 6.00.3790.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <036601c367e0$01adabc0$2a01010a@avwindows>
 <3F457A19.8E8A1F65@gmx.de> <04b901c36852$dccc7660$2a01010a@avwindows>
 <3F45830A.5C0F5BCA@gmx.de> <053301c3685c$9ea6fe50$2a01010a@avwindows>
 <3F4618FF.BDC97C99@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all of you for helping me to resole the problem of "ctrl+c disable".

and now, the problem has been resolved.At the very start,when the system start,it give the user a shell prompt directly,at this instance,the "ctrl+c" disable. Afterward,I change the file of "/etc/inittab" as this:"s1:12345:respawn:/sbin/agetty 9600 ttyS0 vt100",then the problem is resolved.Maybe this is a apish a mistake.
:-)

thanks

Bill

----- Original Message ----- 
From: "Edgar Toernig" <froese@gmx.de>
To: "Bill J.Xu" <xujz@neusoft.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, August 22, 2003 9:22 PM
Subject: Re: "ctrl+c" disabled!


> "Bill J.Xu" wrote:
> > 
> > after run od -tx1, the following is the result
> > ------------------------------------------------
> > bash-2.05# ./od -tx1
> > 0000000
> > ------------------------------------------------
> 
> Either terminal sends nothing or line-discipline caught ^C correctly
> but sent signal to wrong process or process ignores sigint.
> 
> > and I use "killall xxx_appname" to kill the progress after telnet the linux box.
> 
> Check whether "killall -INT xxx_appname" is able to kill the process.
> 
> Try killing the process via Ctrl-Z and then "kill %%".
> 
> Ciao, ET.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
