Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUBRHzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUBRHzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:55:09 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:11957 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S263775AbUBRHzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:55:05 -0500
Date: Wed, 18 Feb 2004 08:54:58 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040218075458.GH1146@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org> <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org> <Pine.LNX.4.58.0402171531570.2154@home.osdl.org> <16434.56190.639555.554525@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16434.56190.639555.554525@samba.org>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 02:26:54PM +1100, tridge@samba.org wrote:
> Even within UCS-2 land the case-mapping table is sparse as only some
> characters have a upper/lower mapping. In fact, there are just 636
> characters out of 64k that have an upper/lower case mapping that isn't
> the identity. That is across *all* languages that windows uses for
> UCS-2.

This is because scripts differentiating between upper and lower case are
rare exceptions in the world.

Unfortunately, commonly used exceptions, and still locale dependent.

Having a samba-helper kernel module that would contain this table (I am
confident that it's only a single table in existing versions of windows,
but maybe they improve that in future versions) could solve this problem.

I still wonder wether it ever can be made efficient, though.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
