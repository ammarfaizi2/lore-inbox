Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSBAXSm>; Fri, 1 Feb 2002 18:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292132AbSBAXSW>; Fri, 1 Feb 2002 18:18:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:524 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292131AbSBAXST>; Fri, 1 Feb 2002 18:18:19 -0500
Subject: Re: [evms-devel] [linux-lvm] [ANNOUNCE] LVM reimplementation ready for beta testing
To: corryk@us.ibm.com (Kevin Corry)
Date: Fri, 1 Feb 2002 23:30:16 +0000 (GMT)
Cc: thornber@fib011235813.fsnet.co.uk (Joe Thornber), linux-lvm@sistina.com,
        evms-devel@lists.sourceforge.net, Jim@mcdee.net (Jim McDonald),
        adilger@turbolabs.com (Andreas Dilger), linux-kernel@vger.kernel.org
In-Reply-To: <02020115304301.00650@boiler> from "Kevin Corry" at Feb 01, 2002 03:59:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Wn8K-0006Rf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I'm trying to envision it, the EVMS runtime would become a "volume 
> recognition" framework (see tanget below). Every current EVMS plugin would 

Volume recognition is definitely a user space area. There are a huge array
of things you want to do in some environments that you cannot do from
kernel space

Simple example: We have mount by label, imagine trying to extend that in
kernel space to automatically do LDAP queries to find a remote handle to
the volume and NFS mount it. It's easy in user space.

Alan
