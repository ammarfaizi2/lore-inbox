Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVCOWwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVCOWwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCOWuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:50:15 -0500
Received: from CPE-144-136-221-26.sa.bigpond.net.au ([144.136.221.26]:39728
	"EHLO modra.org") by vger.kernel.org with ESMTP id S262053AbVCOWsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:48:41 -0500
Date: Wed, 16 Mar 2005 09:18:36 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] No-exec support for ppc64
Message-ID: <20050315224836.GD21148@bubble.modra.org>
Mail-Followup-To: Jake Moilanen <moilanen@austin.ibm.com>,
	Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org
References: <20050308165904.0ce07112.moilanen@austin.ibm.com> <20050308170826.13a2299e.moilanen@austin.ibm.com> <20050310032213.GB20789@austin.ibm.com> <20050310162513.74191caa.moilanen@austin.ibm.com> <16949.25552.640180.677985@cargo.ozlabs.ibm.com> <20050314155125.68dcff70.moilanen@austin.ibm.com> <16950.3484.416343.832453@cargo.ozlabs.ibm.com> <20050315155135.11b942ef.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315155135.11b942ef.moilanen@austin.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 03:51:35PM -0600, Jake Moilanen wrote:
> I believe the problem is that the last PT_LOAD entry does not have the
> correct size, and we only mmap up to the sbss.  The .sbss, .plt, and
> .bss do not get mmapped with the section.

Huh?  .sbss, .plt and .bss have no file contents, so of course p_filesz
doesn't cover them.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
