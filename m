Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSEBMy7>; Thu, 2 May 2002 08:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314393AbSEBMy6>; Thu, 2 May 2002 08:54:58 -0400
Received: from ns.suse.de ([213.95.15.193]:6668 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314389AbSEBMy6>;
	Thu, 2 May 2002 08:54:58 -0400
Date: Thu, 2 May 2002 14:54:56 +0200
From: Dave Jones <davej@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: Linux 2.5.12-dj1
Message-ID: <20020502145456.B16935@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, rwhron@earthlink.net,
	linux-kernel@vger.kernel.org, gibbs@scsiguy.com
In-Reply-To: <20020502072010.A26936@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 07:20:10AM -0400, rwhron@earthlink.net wrote:
 > This is the output while compiling aic7xxx_old.c:
 > 
 > aic7xxx_old.c:11950: unknown field `abort' specified in initializer
 > aic7xxx_old.c:11950: unknown field `reset' specified in initializer

Stereotypical "needs error handling code" errors.

 > aic7xxxx_old.c compiles in 2.5.12 and 2.5.7-dj3, although it may
 > be broken in some other way.

Yep. Removal of the abort/reset methods shows us which SCSI drivers
don't have any error handling. So they 'worked' up until you got
an error, and then...

 > Is it appropriate to edit .config to use the new driver by setting:
 > CONFIG_SCSI_AIC7XXX=y
 > CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
 > CONFIG_AIC7XXX_RESET_DELAY_MS=15000
 > Is the new driver experimental, or ?

I've no experience of either driver in practice, so I'm not actually
sure what the game plan is here. Someone want to fill us in? Justin?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
