Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270801AbUJUSn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270801AbUJUSn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270800AbUJUSnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:43:02 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54237 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270812AbUJUSkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:40:43 -0400
Subject: Re: [2.6.9-ac1] "suid_dumpable" [security/commoncap.ko] undefined
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Piotr Kaczuba <pepe@attika.ath.cx>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098379429l.8350l.0l@orbiter>
References: <1098379429l.8350l.0l@orbiter>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098380274.17095.162.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 18:37:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 18:23, Piotr Kaczuba wrote:
> Building the kernel reports this when building modules:
> 
> *** Warning: "suid_dumpable" [security/commoncap.ko] undefined!
> 
> The capability module fails then to load because it depends on  
> commoncap. As a consequence bind cannot be run with the -u option to  
> switch its user.

Thanks. Add

EXPORT_SYMBOL(suid_dumpable) to fs/exec.c and that should fix it. I'll
fix it for -ac3

