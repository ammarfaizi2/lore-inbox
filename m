Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUENPsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUENPsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUENPsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:48:13 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:60841 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261568AbUENPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:48:11 -0400
Date: Fri, 14 May 2004 19:47:49 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mathieu Chouquet-Stringer <mchouque@online.fr>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: Oops on alpha with 2.6.6 while loading aic7xxx driver
Message-ID: <20040514194749.A31100@jurassic.park.msu.ru>
References: <20040513194511.GA18200@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040513194511.GA18200@localhost>; from mchouque@online.fr on Thu, May 13, 2004 at 03:45:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 03:45:11PM -0400, Mathieu Chouquet-Stringer wrote:
> I just freshly compiled 2.6.6 using gcc 3.4.0 (built as a cross-compiler on
> i386) and the kernel oopses when it loads the module for the Adaptec scsi
> card. As a side note, it works when the driver is built-in.

Yes, I see oopses with some other modules compiled with native
gcc-3.4.0 as well. No such problems with gcc-3.3.3.

At the moment I can suggest that gcc-3.4.0 generates some new types
of relocations and the kernel module loader doesn't handle them properly.
I'll try to figure out what's wrong there, but it will take some time.

Ivan.
