Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314362AbSEBLUn>; Thu, 2 May 2002 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314377AbSEBLUm>; Thu, 2 May 2002 07:20:42 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:22665 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S314362AbSEBLUl>; Thu, 2 May 2002 07:20:41 -0400
Date: Thu, 2 May 2002 07:20:10 -0400
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de
Subject: Re: Linux 2.5.12-dj1
Message-ID: <20020502072010.A26936@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the output while compiling aic7xxx_old.c:

aic7xxx_old.c:11950: unknown field `abort' specified in initializer
aic7xxx_old.c:11950: warning: initialization from incompatible pointer type
aic7xxx_old.c:11950: unknown field `reset' specified in initializer
aic7xxx_old.c:11950: warning: initialization from incompatible pointer type
aic7xxx_old.c:11950: duplicate initializer
aic7xxx_old.c:11950: (near initialization for `driver_template.slave_attach')
aic7xxx_old.c:11950: duplicate initializer
aic7xxx_old.c:11950: (near initialization for `driver_template.bios_param')
make[3]: *** [aic7xxx_old.o] Error 1

aic7xxxx_old.c compiles in 2.5.12 and 2.5.7-dj3, although it may
be broken in some other way.

Is it appropriate to edit .config to use the new driver by setting:
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000

Is the new driver experimental, or ?

-- 
Randy Hron

