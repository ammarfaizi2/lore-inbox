Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314204AbSEBBFd>; Wed, 1 May 2002 21:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314208AbSEBBFc>; Wed, 1 May 2002 21:05:32 -0400
Received: from dsl-213-023-038-139.arcor-ip.net ([213.23.38.139]:53913 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314204AbSEBBFb>;
	Wed, 1 May 2002 21:05:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 03:05:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020501042341.G11414@dualathlon.random> <E172gnj-0001pS-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172iZ6-0001rE-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 May 2002 01:12, I wrote:
> Config_discontigmem
> -------------------
> 
> Has exactly one purpose: to eliminate memory wastage due to struct pages
> that refer to unpopulated regions of memory...

That is, when not used together with config_numa.  When used with config_numa,
it has a second purpose: to allow ->mem_map arrays to exist on the same numa
node as the referenced pages.  The config_nonlinear patch could be extended
to handle this as well (by elaborating the definitions of virt_to_page and
phys_to_page) but I don't have plans to do that at this time.

-- 
Daniel
