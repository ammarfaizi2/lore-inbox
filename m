Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWKLQtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWKLQtI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 11:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755117AbWKLQtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 11:49:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:456 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1755099AbWKLQtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 11:49:05 -0500
X-Authenticated: #24128601
Date: Sun, 12 Nov 2006 17:45:26 +0100
From: Sebastian Kemper <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: idecd: attempt to access beyond end of device
Message-ID: <20061112164526.GA5546@section_eight>
Mail-Followup-To: Sebastian Kemper <sebastian_ml@gmx.net>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <20061112120736.GA4062@section_eight> <20061112155125.799ff7c6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112155125.799ff7c6@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 03:51:25PM +0000, Alan wrote:
> On Sun, 12 Nov 2006 13:07:36 +0100
> Sebastian Kemper <sebastian_ml@gmx.net> wrote:
> 
> > Hello list,
> > 
> > I'm getting these errors trying to mount a burned DVD-R:
> > 
> > Nov  8 12:39:08 section_eight attempt to access beyond end of device
> > Nov  8 12:39:08 section_eight hdc: rw=0, want=68, limit=4
> > Nov  8 12:39:08 section_eight isofs_fill_super: bread failed, dev=hdc,
> > iso_blknum=16, block=1
> > 
> > The drive is a NEC ND-4550A ATAPI. I use idecd and kernel 2.6.18.2.
> 
> Does this occur with ide-scsi as well ?
> 

Hi Alan,

yes, the same happens with ide-scsi:

mount dvdrw/
mount: wrong fs type, bad option, bad superblock on /dev/sr0,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

syslog:

Nov 12 17:41:59 section_eight attempt to access beyond end of device
Nov 12 17:41:59 section_eight sr0: rw=0, want=68, limit=4
Nov 12 17:41:59 section_eight isofs_fill_super: bread failed, dev=sr0,
iso_blknum=16, block=16

Regards
Sebastian
