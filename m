Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289523AbSAOMeB>; Tue, 15 Jan 2002 07:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289533AbSAOMdp>; Tue, 15 Jan 2002 07:33:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42255 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289527AbSAOMcp>; Tue, 15 Jan 2002 07:32:45 -0500
Subject: Re: Hardwired drivers are going away?
To: peter@horizon.com
Date: Tue, 15 Jan 2002 12:44:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020115025840.11509.qmail@science.horizon.com> from "peter@horizon.com" at Jan 15, 2002 02:58:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QSxC-0004yp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) The main kernel is contiguous in physical memory and is mapped with
>    large (4 MB) pages.  This reduces pressure on the TLB.  Modules are
> 2) Space for module code is allocated in page units.  Thus, each module
>    wastes an average of 2K.  If I'm going to have dozens of modules
>    loaded, small machines are going to notice.

If at boot time we keep a big chunk of ram free at the kernel end and just
load modules one after each other into that space until we get into real
paging that problem goes away
