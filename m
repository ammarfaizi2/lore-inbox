Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVADGRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVADGRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 01:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVADGRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 01:17:47 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:21175 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262228AbVADGRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 01:17:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Tue, 4 Jan 2005 01:17:28 -0500
User-Agent: KMail/1.6.2
Cc: Roey Katz <roey@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <d120d50005010308355783c996@mail.gmail.com> <Pine.NEB.4.61.0501040543490.25801@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501040543490.25801@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501040117.28803.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 January 2005 12:49 am, Roey Katz wrote:
> Dmitry,
> 
> I have tried kernels 2.6.9-rc2-bk3 and 2.6.9-rc2-bk4. I first copied the 
> .config from the stripped-down 2.6.10 into the 2.6.9- directories and then 
> ran make oldconfig (hopefully make oldconfig works in reverse?).  Then I 
> built and ran the kernels. Both exhibit the same behavior as 2.6.10 
> regarding the keyboard.
> 
> The /var/log/{dmesg,syslog,messages,kern.log} files for both kernels are 
> available at:
> 
>   http://roey.freeshell.org/mystuff/kernel/
> 
> 
> - Roey
> 
> PS:  I forgot the log_buf_len=131072, hope it's ok for you...
> PPS: I also forgot "acpi=off".  Should I re-run these tests?
> 

Ok, it looks that the big input update is not to blame. Just to make sure
could you re-run the tests with -bk3 and -bk4 but with powering the box
down instead of simply rebooting to ensure that noth kernels get completely
fresh start. If keyboard still does not work I am afraid you will have to
resort to binary search to figure out which 2.6.9-*-bk is at fault. 

-- 
Dmitry
