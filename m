Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290594AbSBFPD4>; Wed, 6 Feb 2002 10:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSBFPDs>; Wed, 6 Feb 2002 10:03:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57608 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290592AbSBFPDh>; Wed, 6 Feb 2002 10:03:37 -0500
Subject: Re: kernel: ldt allocation failed
To: ak@suse.de (Andi Kleen)
Date: Wed, 6 Feb 2002 14:13:45 +0000 (GMT)
Cc: vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko),
        linux-kernel@vger.kernel.org
In-Reply-To: <p73ofj2lpdg.fsf@oldwotan.suse.de> from "Andi Kleen" at Feb 06, 2002 02:19:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YSpV-0005Es-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> glibc 2.3 seems to plan to use segment register based thread local data for 
> even non threaded programs, so it would be a good idea to optimize LDT 
> allocation a bit (= not allocate 64K of vmalloc space every time 
> sys_modify_ldt is called - there is only 8MB of it) 

I think it would be a good idea to modify the glibc authors in that case.
The ldt costs real performance on task switches. It would be very dumb of
glibc to use it except when justified in the bigger picture - ie threaded
apps
