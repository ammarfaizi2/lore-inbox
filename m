Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVCKIew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVCKIew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 03:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCKIev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 03:34:51 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:16520 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262598AbVCKIeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 03:34:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.22566.593812.759201@wombat.chubb.wattle.id.au>
Date: Fri, 11 Mar 2005 19:34:46 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Greg KH <greg@kroah.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for 2.6.11)
In-Reply-To: <20050311071825.GA28613@kroah.com>
References: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU>
	<20050311071825.GA28613@kroah.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Greg> On Fri, Mar 11, 2005 at 02:37:17PM +1100, Peter Chubb wrote:
>> +/* + * The PCI subsystem is implemented as yet-another pseudo
>> filesystem, + * albeit one that is never mounted.  + * This is its
>> magic number.  + */ +#define USR_PCI_MAGIC (0x12345678)

Greg> If you make it a real, mountable filesystem, then you don't need
Greg> to have any of your new syscalls, right?  Why not just do that
Greg> instead?


The only call that would go is usr_pci_open() -- you'd still need 
usr_pci_map(), usr_pci_unmap() and usr_pci_get_consistent().

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

