Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938022AbWLHKzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938022AbWLHKzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425345AbWLHKzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:55:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47939 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938022AbWLHKzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:55:02 -0500
Date: Fri, 8 Dec 2006 02:53:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>,
       Randy Dunlap <randy.dunlap@oracle.com>, shai.satt@intel.com,
       Andi Kleen <ak@suse.de>, hpa@zytor.com
Subject: Re: [PATCH] efi is_memory_available ia64 hack build fix
Message-Id: <20061208025312.70a72d4c.akpm@osdl.org>
In-Reply-To: <20061208103336.4644.96389.sendpatchset@jackhammer.engr.sgi.com>
References: <20061208103336.4644.96389.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 02:33:36 -0800
Paul Jackson <pj@sgi.com> wrote:

> The addition of an is_available_memory() routine to some arch i386
> code, along with an extern for it in efi.h, caused the ia64 build
> to fail, which has the apparently identical routine, marked 'static'.
> 
> The ia64 build fails with:
> 
> arch/ia64/kernel/efi.c:229: error: static declaration of 'is_available_memory' follows non-static declaration
> include/linux/efi.h:305: error: previous declaration of 'is_available_memory' was here              

That already got named to is_memory_available()

(Which I suspect is the wrong fix, because the function serves the same
purpose on ia64 as it does on x86[_64], but nobody listens to me)
