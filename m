Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWBJL1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWBJL1s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWBJL1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:27:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750936AbWBJL1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:27:47 -0500
Date: Fri, 10 Feb 2006 03:26:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: dada1@cosmosbay.com, ak@muc.de, ashok.raj@intel.com, ntl@pobox.com,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060210032622.7f935d30.akpm@osdl.org>
In-Reply-To: <20060210032332.13ed3b67.akpm@osdl.org>
References: <20060209160808.GL18730@localhost.localdomain>
	<20060209090321.A9380@unix-os.sc.intel.com>
	<20060209100429.03f0b1c3.akpm@osdl.org>
	<200602101102.25437.ak@muc.de>
	<20060210024222.67db06f3.akpm@osdl.org>
	<43EC7473.20109@cosmosbay.com>
	<20060210032332.13ed3b67.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> (Probably the most expensive ones will be get_page_state() and friends. 
>  And argh, they're still hardwired to CPU_MASK_ALL).
> 

No, we mask it with cpu_online_map.  Phew.
