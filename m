Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVAGAOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVAGAOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVAGAEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:04:41 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:57308 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263136AbVAGABx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:01:53 -0500
Date: Thu, 6 Jan 2005 18:58:28 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: fs/coda/dir.c: coda_hasmknod seems to be buggy
Message-ID: <20050106235828.GA8152@delft.aura.cs.cmu.edu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050106214053.GA28628@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106214053.GA28628@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 10:40:53PM +0100, Adrian Bunk wrote:
> Function coda_mknod in fs/coda/dir.c (I checked 2.6.10-mm2) stats with:

Thanks, 

Device nodes do not make much sense in a distributed filesystem. I never
removed this code just in case anyone (i.e. not Coda) was using it, but
you just proved that there can be no other user of this code.

I'll remove the has_mknod related parts.

Jan
