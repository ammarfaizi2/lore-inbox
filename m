Return-Path: <linux-kernel-owner+w=401wt.eu-S932193AbXARLj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbXARLj3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 06:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbXARLj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 06:39:29 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:51199 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbXARLj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 06:39:28 -0500
Subject: Re: [PATCH 1/2] Consolidate bust_spinlocks()
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Alexey Dobriyan <adobriyan@openvz.org>
Cc: akpm@osdl.org, dev@sw.ru, linux-kernel@vger.kernel.org, devel@openvz.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20070118111626.GA6040@localhost.sw.ru>
References: <20070118111626.GA6040@localhost.sw.ru>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 18 Jan 2007 12:39:25 +0100
Message-Id: <1169120365.5621.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 14:16 +0300, Alexey Dobriyan wrote:
> From: Kirill Korotaev <dev@sw.ru>
> 
> Part of long forgotten patch
> http://groups.google.com/group/fa.linux.kernel/msg/e98e941ce1cf29f6?dmode=source
> Since then, m32r grabbed two copies.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
> ---
> 
>  arch/i386/mm/fault.c       |   26 --------------------------
>  arch/ia64/kernel/traps.c   |   30 ------------------------------
>  arch/m32r/mm/fault-nommu.c |   26 --------------------------
>  arch/m32r/mm/fault.c       |   26 --------------------------
>  arch/s390/mm/fault.c       |   26 --------------------------
>  arch/x86_64/mm/fault.c     |   21 ---------------------
>  lib/Makefile               |    4 ++--
>  lib/bust_spinlocks.c       |    2 +-
>  8 files changed, 3 insertions(+), 158 deletions(-)

NACK for the s390 part. lib/bust_spinlocks.c does an unblank_screen if
CONFIG_VT is defined. That is not good enough for s390 because we do not
have CONFIG_VT nor unblank_screen but still require that console_unblank
is called.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


