Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVB0GyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVB0GyA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 01:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVB0GyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 01:54:00 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:38710 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261360AbVB0Gxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 01:53:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=gC0U11/KRfj7eKBMUSTJyFV6dHzaEFVNOKxL6018LRH6dnrlE2S2dr28LmZehLCPYDZ0sj8j0w5SLXkWUsonTzpGJ7u/Th2Yppp302wedEs71MZXeKoTWvnDpbg6E6AMCax7XK0IJ7EJeu1L7YRdsLzuZgh6u0KicSTVrSoHfaI=
Date: Sun, 27 Feb 2005 15:53:48 +0900
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 10/11] ide: make ide_cmd_ioctl() use TASKFILE
Message-ID: <20050227065348.GB27728@htj.dyndns.org>
References: <20050210083808.48E9DD1A@htj.dyndns.org> <20050210083854.BD13DFBD@htj.dyndns.org> <58cb370e050224075040f5c031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050224075040f5c031@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Bartlomiej.

On Thu, Feb 24, 2005 at 04:50:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > +       in_valid->b.status_command      = 1;
> > +       in_valid->b.error_feature       = 1;
> > +       in_valid->b.nsector             = 1;
> 
> ide_end_drive_cmd() must be fixed first to respect ->tf_in_flags
> and it must be done *without* affecting HDIO_DRIVE_TASKFILE.

 Hmmm... does it make any difference other than reading more
registers?  Are you worried about performance impacts?  Is there
hardware which acts differently if more registers are read?

> 
> >  extern int ide_driveid_update(ide_drive_t *);
> > -extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
> > +int ide_ata66_check(ide_drive_t *, ide_task_t *);
> >  extern int ide_config_drive_speed(ide_drive_t *, u8);
> >  extern u8 eighty_ninty_three (ide_drive_t *);
> > -extern int set_transfer(ide_drive_t *, ide_task_t *);
> > +int set_transfer(ide_drive_t *, ide_task_t *);
> >  extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
> 
> leftovers from previous version of the patch

 Yeah, sorry.

 Thanks.

-- 
tejun

