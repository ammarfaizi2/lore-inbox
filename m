Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132585AbRDBAn3>; Sun, 1 Apr 2001 20:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132589AbRDBAnT>; Sun, 1 Apr 2001 20:43:19 -0400
Received: from laurin.munich.netsurf.de ([194.64.166.1]:47305 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S132585AbRDBAnK>; Sun, 1 Apr 2001 20:43:10 -0400
Date: Mon, 2 Apr 2001 02:42:36 +0200
To: Tim Hockin <thockin@isunix.it.ilstu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how mmap() works?
Message-ID: <20010402024236.A5057@storm.local>
Mail-Followup-To: Tim Hockin <thockin@isunix.it.ilstu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010401184131.A2474@storm.local> <200104012028.PAA05467@isunix.it.ilstu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104012028.PAA05467@isunix.it.ilstu.edu>; from thockin@isunix.it.ilstu.edu on Sun, Apr 01, 2001 at 03:28:05PM -0500
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2001 at 03:28:05PM -0500, Tim Hockin wrote:
> > Without syncing, Linux writes whenever it thinks it's appropriate, e.g.
> > when pages have to be freed (I think also when the bdflush writes back
> > data, i.e. every 30 seconds by default).
> 
> what about mmap() on non-filesystem files (/dev/mem, /proc/bus/pci...) ?

They map physically present memory directly and do not have to be
synced, since all writes go directly to their destination (which is of
course not possible with disk files).  I'm not that sure if PCI is a bit
special case though, since not all architectures can access it like
memory.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
