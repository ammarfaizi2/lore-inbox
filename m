Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281676AbRKUIrT>; Wed, 21 Nov 2001 03:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281678AbRKUIrJ>; Wed, 21 Nov 2001 03:47:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50700 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281676AbRKUIqy>; Wed, 21 Nov 2001 03:46:54 -0500
Subject: Re: Shared Memory Problem
To: relson@osagesoftware.com (David Relson)
Date: Wed, 21 Nov 2001 08:54:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011120202550.00c239c0@mail.osagesoftware.com> from "David Relson" at Nov 20, 2001 08:30:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E166T9h-0004N1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I built my own 2.4.15-pre7 kernel today and have a problem - I can't start 
> httpd.  Whenever I try I get the following messages:
> 
> Nov 20 18:53:35 walnut httpd: Ouch! ap_mm_create(1048576, 
> "/var/apache-mm/mm.1529") failed
> Nov 20 18:53:35 walnut httpd: Error: MM: mm:core: failed to acquire shared 
> memory segment (Function not implemented): OS: No such file or directory
> 
> Which kernel CONFIG symbol I have set wrong?

CONFIG_SYSVIPC probably. TMPFS is a shared memory file system and posix
shared memory. Apache uses the older sys5 shared memory standard
