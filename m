Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312396AbSCURTr>; Thu, 21 Mar 2002 12:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312397AbSCURT0>; Thu, 21 Mar 2002 12:19:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35851 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312396AbSCURTQ>; Thu, 21 Mar 2002 12:19:16 -0500
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
To: mgross@unix-os.sc.intel.com
Date: Thu, 21 Mar 2002 17:34:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dan@debian.org (Daniel Jacobowitz),
        vamsi@in.ibm.com (Vamsi Krishna S .), pavel@suse.cz (Pavel Machek),
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        tachino@jp.fujitsu.com, jefreyr@pacbell.net, vamsi_krishna@in.ibm.com,
        richardj_moore@uk.ibm.com, hanharat@us.ibm.com, bsuparna@in.ibm.com,
        bharata@in.ibm.com, asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <200203211707.g2LH7XW10116@unix-os.sc.intel.com> from "Mark Gross" at Mar 21, 2002 09:10:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o6SJ-0005mD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This why I grabbed all those locks, and did the two sets of IPI's in the 
> tcore patch.  Once the runqueue lock is grabbed, even if that process on the 

If you IPI holding a lock whats going to happen if while the IPI is going
across the cpus the other processor tries to grab the runqueue lock and
is spinning on it with interrupts off ?
