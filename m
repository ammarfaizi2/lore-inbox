Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290466AbSAQVSK>; Thu, 17 Jan 2002 16:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290474AbSAQVSC>; Thu, 17 Jan 2002 16:18:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60299 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290473AbSAQVRp>;
	Thu, 17 Jan 2002 16:17:45 -0500
Date: Thu, 17 Jan 2002 13:16:35 -0800 (PST)
Message-Id: <20020117.131635.83624114.davem@redhat.com>
To: engebret@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm_page_prot value
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201171847.g0HIljp01458@skunk.rchland.ibm.com>
In-Reply-To: <200201171847.g0HIljp01458@skunk.rchland.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Engebretsen <engebret@vnet.ibm.com>
   Date: Thu, 17 Jan 2002 12:47:45 -0600

   Following is a patch against 2.4.18-pre3 which fixes a problem where the 
   protection on user stack pages are not marked executable even though 
   the flags indicate the page is executable.  Some more aggressive cache 
   flush optimizations may rely on the execution marking to indicate if a page 
   needs to be flushed as it might be present in an icache which is not 
   coherent with the dcache.

Actually, PAGE_COPY happens to be executable on many platforms.
