Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTJ0R7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTJ0R7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:59:38 -0500
Received: from web13005.mail.yahoo.com ([216.136.174.15]:51213 "HELO
	web13005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263434AbTJ0R7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:59:36 -0500
Message-ID: <20031027175935.15690.qmail@web13005.mail.yahoo.com>
Date: Mon, 27 Oct 2003 09:59:35 -0800 (PST)
From: Mr Amit Patel <patelamitv@yahoo.com>
Subject: Re: as_arq scheduler alloc with 2.6.0-test8-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031026034113.0cfd50d9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The qlogic driver is for Fibre Channel HBA QLA2342.
This is a beta driver which is part of the mjb1 patch
against 2.6.0-test8. As a part of driver insmod,
driver tries to find fiber channel device and maps it
to scsi block device. Actually I don't have any fibre
channel target attached, so driver does not find any
scsi devices and discovery finishes without adding any
block device. 

I am trying to go through driver scsi_scan process and
see when does actual allocation from as_arq happens.
But for some reason after going to kgdb I get SIGEMT
and I cannot debug further. What is causing SIGEMT
cause after doing some search looks like its actually
SIGUSR but linux treats it as SIGEMT. Is there any way
to prevent SIGEMT when I want to use kgdb ? 

Thanks for your help,

Amit
--- Andrew Morton <akpm@osdl.org> wrote:
> Mr Amit Patel <patelamitv@yahoo.com> wrote:
> >
> > I am using 2.6.0-test8-mm1 kernel. I am using
> qlogic
> >  driver patch with 
> >  this kernel
> 
> What qlogic driver patch is this?
> 


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
