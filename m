Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316670AbSE1OyO>; Tue, 28 May 2002 10:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSE1OyN>; Tue, 28 May 2002 10:54:13 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:7639 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S316670AbSE1OyM>;
	Tue, 28 May 2002 10:54:12 -0400
Date: Tue, 28 May 2002 07:53:58 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Josh Fryman <fryman@cc.gatech.edu>, linux-kernel@vger.kernel.org
Subject: Re: changing __PAGE_OFFSET on x86?
Message-ID: <1918725992.1022572437@[10.10.2.3]>
In-Reply-To: <20020528101515.56785de1.fryman@cc.gatech.edu>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to fix this, if we change the __PAGE_OFFSET in include/asm-i386/page.h 
> from 0xc0000000 to 0xb000000, are there any hidden dependencies?  is 
> there anything else we need to worry about?  

Change arch/i386/vmlinux.lds as well (or the equiv on your machine).

> (does the __PAGE_OFFSET need to lie on a 1G boundary?)

Only if you're running PAE (64Gb support).

M.

PS. the -aa tree (Andrea's) has a config option to change this.
