Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSFSWan>; Wed, 19 Jun 2002 18:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318039AbSFSWam>; Wed, 19 Jun 2002 18:30:42 -0400
Received: from ns.suse.de ([213.95.15.193]:30989 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318038AbSFSWak>;
	Wed, 19 Jun 2002 18:30:40 -0400
Date: Thu, 20 Jun 2002 00:30:41 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rvandijk@science.uva.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Message-ID: <20020620003041.U29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rvandijk@science.uva.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <200206192133.g5JLXH814796@mail.science.uva.nl> <20020619234035.R29373@suse.de> <200206192213.g5JMDu823286@mail.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206192213.g5JMDu823286@mail.science.uva.nl>; from rvandijk@science.uva.nl on Thu, Jun 20, 2002 at 12:16:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 12:16:59AM +0200, Rudmer van Dijk wrote:
 > PCI: Using IRQ router SIS [1039/0008] at 00:02.0
 > __iounmap: bad address d0802030
 > .. 
 > I just saw the iounmap error, maybe related??

No, that happens earlier. No idea what causes it, but it's obviously
a problem somewhere..

 > however, when I started X from the bootscript, that is the bootscript starts 
 > kdm which in turn starts the X server, I got the same oops as before...
 > the process that causes the oops appears to be chmod, if you want the whole 
 > oops, please tell and I will write it down (cannot use a serial console...).

Please do. And feed it through ksymoops please.

 > so the agpgart split seems to work fine here, but there is clearly something 
 > wrong when kde2 tries to start.

Finger of suspicion points to..
http://www.codemonkey.org.uk/patches/merged/2.5.23/dj2/poll-select-fast-path.diff

Apply this (with -R), and see if it goes away. 

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
