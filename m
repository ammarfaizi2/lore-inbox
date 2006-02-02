Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423431AbWBBJvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423431AbWBBJvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423428AbWBBJvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:51:11 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:48894 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1423429AbWBBJvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:51:10 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 02 Feb 2006 10:49:33 +0100
To: jengelh@linux01.gwdg.de, bzolnier@gmail.com
Cc: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E1D5AD.nail4MI2R8NR2@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com>
 <43DF678E.nail3B431CUWJ@burner>
 <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com>
 <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> Which unfortunately leads us back to one of the early questions.
>
> If ATAPI is some sort of SCSI [command set] over ATA, and ide-cd can be used
> without the "Big Bad" SCSI layer (CONFIG_SCSI), don't we have redundant code
> floating around?

CONFIG_SCSI???

Why not using fully dynamical loadable kernel modules as done with Solaris 
since 1992? Since that time nobody cares because what you need is auto-loaded 
on demand and there is absolutely no need for a manual configuration.

BTW: Introducing an orthogonal SCSI based implementation would save a lot of
code. The model currently used on Linux is duplicating a lot of unneeded code 
in target drivers and the SCSI glue code is only a few KB (less than 30k on 
Solaris). 

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
