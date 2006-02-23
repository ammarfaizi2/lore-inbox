Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWBWObj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWBWObj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 09:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWBWObj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 09:31:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:58059 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751240AbWBWObi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 09:31:38 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Patch to make the head.S-must-be-first-in-vmlinux order explicit
Date: Thu, 23 Feb 2006 15:14:02 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <200602231442.19903.ak@suse.de> <43FDBF55.3060502@linux.intel.com>
In-Reply-To: <43FDBF55.3060502@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231514.03001.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 14:57, Arjan van de Ven wrote:

> > (or at least
> > it shouldn't), but arch/x86_64/boot/compressed/head.S
> > seems to have the entry address hardcoded. Perhaps you can just change this
> > to pass in the right address?
> 
> the issue is that the address will be a link time thing, which means 
> lots of complexity.

bzImage image should be only generated after vmlinux is done 
and then the address should be available with a simple grep in System.map

-Andi
