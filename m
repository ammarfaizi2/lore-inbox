Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280026AbRKIS6z>; Fri, 9 Nov 2001 13:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280021AbRKIS6f>; Fri, 9 Nov 2001 13:58:35 -0500
Received: from fandango.cs.unitn.it ([193.205.199.228]:49414 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S279997AbRKIS6d>; Fri, 9 Nov 2001 13:58:33 -0500
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200111091857.TAA26884@fandango.cs.unitn.it>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
In-Reply-To: <12948.1005329220@redhat.com> from David Woodhouse at "Nov 9, 2001
 06:07:00 pm"
To: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 9 Nov 2001 19:57:04 +0100 (MET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> dz@cs.unitn.it said:
> >  Since I can't fix the SMM BIOS I think there is very little I can do,
> > except avoiding the GET_POWER_STATUS call which uses half of the time.
> > I will try to get the same information from /proc/apm.
> 
> APM will probably take the same amount of time, and indeed be the same code.
> It'd be best to work out how to talk to the stuff on the i2c bus directly
> from Linux.
> 
> --
> dwmw2

Yes, but since GET_POWER_STATUS is not really needed to control the fans
I plan to remove it from /proc/i8k and use /proc/apm which provides the
same information but can be read less frequently. Once per minute would
be fine if it is neede only to use different temperature thresholds.
This would save half of the cpu time spent in the SMM bios.
Also a higher timeout would help. Probably 5 seconds would be ok.

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: massimo.dalzotto@libero.it   |
|  Via Marconi, 141                phone: ++39-461534251               |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                                  http://www.debian.org/~dz/   |
|  gpg:   2DB65596  3CED BDC6 4F23 BEDA F489 2445 147F 1AEA 2DB6 5596  |
+----------------------------------------------------------------------+
