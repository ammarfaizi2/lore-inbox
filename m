Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVDHAn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVDHAn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVDHAn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:43:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:40144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262616AbVDHAn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:43:56 -0400
Date: Thu, 7 Apr 2005 17:44:28 -0700
From: Nick Wilson <njw@osdl.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org
Subject: [PATCH 0/6] add generic round_up_pow2() macro
Message-ID: <20050408004428.GA4260@njw.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> >+#define ALIGN_DATA_SIZE(size)       ((size + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1))                      
>                                                                                                        
> ISTM that we need a generic round_up() function or macro in kernel.h.                                  
>                                                                                                        
> a.out.h, reiserfs_fs.h, and ufs_fs.h all have their own round-up                                       
> macros.                                                                                                
 
I've found many more places in the kernel that use their own functions for
doing this. These patches are the beginning of an attempt to clean these
up.

The first patch adds a generic round_up_pow2() macro to kernel.h. The
remaining patches modify a few files to make use of the new macro.
Comments welcome.

Thanks,
        
Nick
