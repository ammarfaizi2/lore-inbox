Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278676AbRJSWAH>; Fri, 19 Oct 2001 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278675AbRJSV7r>; Fri, 19 Oct 2001 17:59:47 -0400
Received: from a1as17-p73.stg.tli.de ([195.252.193.73]:4585 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S278673AbRJSV7f>; Fri, 19 Oct 2001 17:59:35 -0400
Date: Fri, 19 Oct 2001 23:59:51 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: pci_alloc_consistent question
Message-ID: <20011019235951.A29083@dea.linux-mips.net>
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4A5@axcs13.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4A5@axcs13.cos.agilent.com>; from hiren_mehta@agilent.com on Fri, Oct 19, 2001 at 03:24:14PM -0600
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 03:24:14PM -0600, MEHTA,HIREN (A-SanJose,ex1) wrote:

> so, what is the conservative number ? 1MB ?

Even far below that.  Most systems will allocate that memory using
get_free_pages and by allocating large pages such as 1mb you'll produce
high memory pressure.  Try to get away with PAGE_SIZE * 2 if you can.
Large allocation are only ok if they're rare.

  Ralf
