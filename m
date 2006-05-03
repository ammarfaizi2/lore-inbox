Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWECNBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWECNBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWECNBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:01:32 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:3308 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030183AbWECNBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:01:31 -0400
Date: Wed, 3 May 2006 15:00:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060503130043.GC19537@wohnheim.fh-wedel.de>
References: <20060503123339.GB19537@wohnheim.fh-wedel.de> <OF4A608E41.FE0C2D7F-ON42257163.00461225-42257163.0046AB62@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF4A608E41.FE0C2D7F-ON42257163.00461225-42257163.0046AB62@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 14:51:53 +0200, Michael Holzheu wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 05/03/2006 02:33:39 PM:
> 
> > Applications will depend on some arcane detail of your format.  They
> > will depend on exactly five spaces in "foo     bar".  It does not even
> > matter if you documented "any amount of whitespace".  The application
> > knows that it was five spaces and doesn't care.  And once you change
> > it, the blame will be on you, because you broke existing userspace.
> 
> Again, logically there is no difference between the two solutions. It does
> not matter, if you have one file with:
> 
> <cpu>
>     <0>
>        <onlinetime = 4711>
>     <\0>
> <\cpu>

Userspace can make your life hell by depending on indentation via 4
spaces.  The problem is that you don't necessarily know that it does
until you managed to change indentation.

In a filesystem tree, it is fairly hard to make assumptions that are
later broken.  It is by no means impossible, agreed.  But the
"indentation" doesn't exist anymore.  A file is part of a subdirectory
or it isn't.  Opening tags without matching closing tags don't exist
either.  List goes on.

In the end, both formats can get abused in ways you'd never foresee.
But the directory tree considerably raises the barrier.

Jörn

-- 
He who knows that enough is enough will always have enough.
-- Lao Tsu
