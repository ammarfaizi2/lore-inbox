Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWECKBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWECKBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 06:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWECKBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 06:01:39 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:21434 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965137AbWECKBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 06:01:38 -0400
Date: Wed, 3 May 2006 12:01:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060503100108.GA19537@wohnheim.fh-wedel.de>
References: <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <OF0EA76F71.9AA7937D-ON42257163.003067FA-42257163.00347656@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF0EA76F71.9AA7937D-ON42257163.003067FA-42257163.00347656@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 11:33:01 +0200, Michael Holzheu wrote:
> 
> All the complicated mechanisms with filesystem trees
> to obtain consistent data and transaction functionality
> could be avoided, if we would use single files, which
> contain all the data. When opening the file, the snapshot
> is created and attached to the struct file.

s/single file/single entity/ and this may be useful.  Your filesystem
exports a directory tree, which is nice and easily parsable.  The
problem is that it is a single resource for everyone.  If different
users could have their own views of this filesystem, each with a
private snapshot, many problems would be solved.

Spufs might have something similar already.  Istr something about
returning a directory fd and then using openat(2) and friends.

Jörn

-- 
To my face you have the audacity to advise me to become a thief - the worst
kind of thief that is conceivable, a thief of spiritual things, a thief of
ideas! It is insufferable, intolerable!
-- M. Binet in Scarabouche
