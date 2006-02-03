Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWBCNb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWBCNb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWBCNb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:31:26 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:50895 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750774AbWBCNbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:31:25 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 14:29:44 +0100
To: rlrevell@joe-job.com, jim@why.dont.jablowme.net
Cc: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E35AC8.nail5CAD55WJ3@burner>
References: <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
 <20060202210949.GD10352@voodoo> <1138915551.15691.123.camel@mindpipe>
In-Reply-To: <1138915551.15691.123.camel@mindpipe>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2006-02-02 at 16:09 -0500, Jim Crilly wrote:
> > Apparently O_EXCL was added by Ubuntu and Debian to stop
> > burns being corrupted by hald polling the device while a disc is
> > being burned. 
>
> IO priorities are the correct solution...

No, they are not. 

The correct solution is to implement "hald" in a _cooperative_ way 
like e.g. vold on Solaris.

The main point is not to poll to frequent (Solaris does once everz 3 seconds)
and to use SCSI commands only that to not interrupt or disturb CD/DVD-writing.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
