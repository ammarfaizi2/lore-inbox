Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUHSPc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUHSPc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUHSPcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:32:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:63619 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266254AbUHSPbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:31:23 -0400
Subject: Re: 2.6.8.1-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Cherry <cherry@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092927166.29916.0.camel@cherrybomb.pdx.osdl.net>
References: <20040819014204.2d412e9b.akpm@osdl.org>
	 <1092927166.29916.0.camel@cherrybomb.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092925743.28350.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 15:29:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 15:52, John Cherry wrote:
> The new "errors" are from reiser4 code and they all appear to be...
> 
> fs/reiser4/reiser4.h:18:2: #error "Please turn 4k stack off"

If you change that for "#error "Please fix your stack usage"" it
fixes one bug.

You could also make reiser4 depend on not selecting 4K stacks and that
will make the config code do the right thing.

Alan

