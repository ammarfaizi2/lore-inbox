Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUKCT4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUKCT4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbUKCTzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:55:38 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:30341 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261853AbUKCTj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:39:56 -0500
Date: Wed, 3 Nov 2004 20:42:26 +0100
From: DervishD <lkml@dervishd.net>
To: Gene Heskett <gheskett@wdtv.com>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041103194226.GA23379@DervishD>
Mail-Followup-To: Gene Heskett <gheskett@wdtv.com>,
	linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031353.39468.gene.heskett@verizon.net> <200411031906.iA3J6QCj018875@turing-police.cc.vt.edu> <200411031426.23880.gheskett@wdtv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411031426.23880.gheskett@wdtv.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Gene :)

 * Gene Heskett <gheskett@wdtv.com> dixit:
> >Traditionally, a common cause for such wedging was a lost/misplaced
> > interrupt from an I/O operation, so a read()/write()/ioctl() call
> > wouldn't return because the device hadn't reported it completed.
> > (tape drives were notorious for this). Often, power-cycling the I/O
> > device would cause an unsolicited interrupt to be generated, which
> > would clear the "waiting for interrupt" issue and allow the process
> > to return....
> Well, since the "device", a bt878 based Haupagge tv card is sitting in 
> a pci socket, thats even more drastic than a reboot.

    Do you mean your Hauppage got stuck in disk-sleep state? Wow,
that's sound *weird*...

    I think that the parent (which is whatever process did the fork
when you clicked your mouse) is still alive and forgetting to do the
'wait()' for its children.
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
