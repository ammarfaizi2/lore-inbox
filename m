Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUIECxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUIECxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUIECxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:53:25 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:36447 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266133AbUIECxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:53:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: external firewire dvd writer
Date: Sat, 4 Sep 2004 21:53:19 -0500
User-Agent: KMail/1.6.2
Cc: Clemens Schwaighofer <cs@tequila.co.jp>
References: <413A799C.1000505@tequila.co.jp> <413A7B61.2000603@tequila.co.jp>
In-Reply-To: <413A7B61.2000603@tequila.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409042153.20030.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 September 2004 09:35 pm, Clemens Schwaighofer wrote:
> Clemens Schwaighofer wrote:
> | Hi,
> |
> | I have an external Pioneer DVD writer which I connect via Firewire to my
> | laptop. So when I turn it on I get this in my dmesg:
> 
> and I idiot totaly forgot to give the key information :)
> 
> its a 2.6.8.1-mm4 kernel, but I had the same issue with a vaniall
> 2.6.8.1 kernel
> 

Did you compile SCSI CD-ROM support? If you did try loading sr_mod. Works 
fine here, just don't forget to rmmod sr_mod before turning off the DVD
as it seems that there is a problem with hot removal either in sr_mod or
in firewire system (I am inclned to say its sr_mod as sd_mod seems to
handle surprise removal OK).

-- 
Dmitry
