Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVCVRNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVCVRNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVCVRNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:13:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48392 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261444AbVCVRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:13:42 -0500
Date: Tue, 22 Mar 2005 18:13:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
Message-ID: <20050322171340.GE1948@stusta.de>
References: <20050321025159.1cabd62e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321025159.1cabd62e.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

REISER4_FS is the only option with a dependency on !4KSTACKS which is 
bad since 8 kB stacks on i386 won't stay forever.

Could fix the problems with 4 kB stacks?

Running

  make checkstacks | grep reiser4

inside te kernel sources after compiling gives you hints where problems 
might come from.


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

