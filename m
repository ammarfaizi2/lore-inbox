Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSFZDr4>; Tue, 25 Jun 2002 23:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316195AbSFZDrz>; Tue, 25 Jun 2002 23:47:55 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:60176 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S316194AbSFZDrz>; Tue, 25 Jun 2002 23:47:55 -0400
Date: Tue, 25 Jun 2002 20:47:47 -0700
From: jw schultz <jw@pegasys.ws>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Urgent, Please respond - Re: max_scsi_luns and 2.4.19-pre10.
Message-ID: <20020625204747.D26789@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Austin Gonyou <austin@digitalroadkill.net>,
	linux-kernel@vger.kernel.org
References: <1025052385.19462.5.camel@UberGeek> <1025056235.19779.4.camel@UberGeek> <20020625194806.C26789@pegasys.ws> <1025060739.20340.6.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1025060739.20340.6.camel@UberGeek>; from austin@digitalroadkill.net on Tue, Jun 25, 2002 at 10:05:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2002 at 10:05:39PM -0500, Austin Gonyou wrote:
> On Tue, 2002-06-25 at 21:48, jw schultz wrote:
> > I'm no expert on this bit but look in
> > drivers/scsi/scsi_scan.c for CONFIG_SCSI_MULTI_LUN 
> > 
> > #ifdef CONFIG_SCSI_MULTI_LUN
> > static int max_scsi_luns = 8;
> > #else
> > static int max_scsi_luns = 1;
> > #endif
> 
> This is, but there seems to be something more fundamental here. I'm
> using the -aa patches, and the static int max_scsi_luns = 8; is actually
> static int max_scsi_luns = MAX_SCSI_LUNS;
> 
> where above is: #define MAX_SCSI_LUNS 0xFFFFFFFF; 
> but I'm not sure if this syntax is 0xFFFFFFFF == 8 or 2^n. 
>
> To me, it seems like 8. I'm using pre10-aa2, I'm going to try pre10-aa4
> as well, but if I must I'm going to hard-code the kernel bits I need I
> supposed to make static int max_scsi_luns = MAX_SCSI_LUNS; into static
> int max_scsi_luns = 16; to ensure it works at the level I need. 
> 

I don't have -aa but that is -1.  I would suggest a bit of
greping.

I seriously doubt changing it to 16 would cause data
corruption.  It will either work or not.  If it doesn't you
will crash on boot/init.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
