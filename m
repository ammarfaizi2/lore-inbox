Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSJaVzj>; Thu, 31 Oct 2002 16:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265363AbSJaVzj>; Thu, 31 Oct 2002 16:55:39 -0500
Received: from fep03-svc.mail.telepac.pt ([194.65.5.202]:37886 "EHLO
	fep03-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id <S265326AbSJaVzf>; Thu, 31 Oct 2002 16:55:35 -0500
Date: Thu, 31 Oct 2002 14:22:14 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: lmtavora@saturno.fis.uc.pt
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 journalling file system
Message-ID: <20021031142214.GA747@hobbes.itsari.int>
References: <200210311309.NAA03653@saturno.fis.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200210311309.NAA03653@saturno.fis.uc.pt>; from lmtavora@saturno.fis.uc.pt on Thu, Oct 31, 2002 at 13:09:13 +0000
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.02 13:09 Luis Miguel Tavora wrote:
> 
> [1.] Ext3 jornalling file system
> 
> [2.] The system pt-get to update RH 7.3, on a
> Compaq M700 Laptop the system is turned into a
> highly critical stage: impossible to lauch
> applications, no disk access and the machine doesn't
> reboot with the shutdown command (but the CPU &
> clock  keep working ok, I think...)

Hi Luis,

Please pipe the oops messages through ksymoops (check 
linux/Documentation/oops-tracing.txt on how to do so), as they're really 
not useful as is. Also, you may want to check 2.4.20-rc1, quite a few ext3 
fixes went in during the .20-pre series. I seem to remember some bugs in 
transaction.c:226 during 2.4.18/.19-pre...

Also, it would help a great deal if you could reproduce the crash without 
any proprietary modules ever being loaded -- your kernel was marked as 
"tainted", although all modules from the list you provide below should be 
ok (GPL or Dual BSD/GPL). Did you have any nVidia binary only drivers 
loaded at the the time of the crash?

Cheers,

		Nuno
