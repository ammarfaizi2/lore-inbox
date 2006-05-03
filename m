Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWECMeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWECMeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWECMeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:34:19 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:6376 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965180AbWECMeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:34:19 -0400
Date: Wed, 3 May 2006 14:33:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060503123339.GB19537@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0605031239001.10675@sbz-30.cs.Helsinki.FI> <OF11F4EFE7.A54CB101-ON42257163.0042DA19-42257163.0042FB13@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF11F4EFE7.A54CB101-ON42257163.0042DA19-42257163.0042FB13@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 14:11:36 +0200, Michael Holzheu wrote:
> 
> Maybe we need that, too. But I think the advantage of the
> one file solution moves the complexity from the kernel
> to userspace.

Now might be a time to come back to Martin's prediction. ;)

Having a weird format in some file does _not_ move complexity from the
kernel.  It may make the userspace more complex, granted.  But once
you try to change something, you need to keep the ABI stable.  And
part of the ABI is you file format.

Applications will depend on some arcane detail of your format.  They
will depend on exactly five spaces in "foo     bar".  It does not even
matter if you documented "any amount of whitespace".  The application
knows that it was five spaces and doesn't care.  And once you change
it, the blame will be on you, because you broke existing userspace.

If that does not make the kernel complex, I don't know what does.

Jörn

-- 
It does not matter how slowly you go, so long as you do not stop.
-- Confucius
