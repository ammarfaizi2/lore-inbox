Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSJWWIb>; Wed, 23 Oct 2002 18:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265254AbSJWWI3>; Wed, 23 Oct 2002 18:08:29 -0400
Received: from host194.steeleye.com ([66.206.164.34]:63748 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265251AbSJWWI2>; Wed, 23 Oct 2002 18:08:28 -0400
Message-Id: <200210232214.g9NMEXR05530@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH] 2.5.44-ac1 : init/do_mounts.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 Oct 2002 17:14:33 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   This patch removes an outdated macro STATIC.

I don't think you want to do this. The definition STATIC alters the behaviour 
of the #included "lib/inflate.c" which is used for uncompressing ramdisks.  I 
think you'll find do_mounts.c may not even compile with it undefined since it 
will now look for a missing "gzip.h" header.

James



