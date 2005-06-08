Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVFHKlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVFHKlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVFHKlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:41:37 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20449 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262156AbVFHKkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:40:31 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Alexander Nyberg <alexn@telia.com>, Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 8 Jun 2005 13:39:56 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
References: <20050607212706.GB7962@stusta.de> <1118180858.956.27.camel@localhost.localdomain>
In-Reply-To: <1118180858.956.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081339.57012.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 00:47, Alexander Nyberg wrote:
> tis 2005-06-07 klockan 23:27 +0200 skrev Adrian Bunk:
> > 4Kb kernel stacks are the future on i386, and it seems the problems it 
> > initially caused are now sorted out.
> > 
> > I'd like to:
> > - get a patch into the next -mm that unconditionally enables 4KSTACKS
> > - if there won't be new reports of breakages, send a patch to
> >   completely remove !4KSTACKS for 2.6.13 or 2.6.14
> > 
> 
> Combinations of IDE/SCSI with MD/DM (maybe even stacking them ontop of
> eachother), NFS and a filesystem in there breaks 4KSTACKS which is a
> known issue so you can't just remove it leaving users with no choice.
> 
> This was not even difficult to trigger a while ago and I haven't seen
> any stack reduction patches in these areas.

Not true. NFS patches were.

Do you have any stack overflow traces? Also "make checkstack" is your friend
in looking for suspect functions.

NB: gcc 3.4.3 can use excessive stack in degenerate cases, so please
include gcc version in your reports.
--
vda

