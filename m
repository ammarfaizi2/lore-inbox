Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbTHVNWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTHVNWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 09:22:14 -0400
Received: from imap.gmx.net ([213.165.64.20]:49835 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263266AbTHVNWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 09:22:12 -0400
Message-ID: <3F4618FF.BDC97C99@gmx.de>
Date: Fri, 22 Aug 2003 15:22:07 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: "Bill J.Xu" <xujz@neusoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: "ctrl+c" disabled!
References: <036601c367e0$01adabc0$2a01010a@avwindows>
	 <3F457A19.8E8A1F65@gmx.de> <04b901c36852$dccc7660$2a01010a@avwindows>
	 <3F45830A.5C0F5BCA@gmx.de> <053301c3685c$9ea6fe50$2a01010a@avwindows>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bill J.Xu" wrote:
> 
> after run od -tx1, the following is the result
> ------------------------------------------------
> bash-2.05# ./od -tx1
> 0000000
> ------------------------------------------------

Either terminal sends nothing or line-discipline caught ^C correctly
but sent signal to wrong process or process ignores sigint.

> and I use "killall xxx_appname" to kill the progress after telnet the linux box.

Check whether "killall -INT xxx_appname" is able to kill the process.

Try killing the process via Ctrl-Z and then "kill %%".

Ciao, ET.
