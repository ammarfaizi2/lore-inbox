Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263439AbVHFT00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbVHFT00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbVHFT00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:26:26 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:14687 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263439AbVHFT0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:26:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=T4407UKg/urdxGB8sKSRwKCRBmGpMne/64AyNgbKfe/Mjcq6e6yFuROTK3OLzNA7J7UA8czO+gKe1qhcy4XWpvy/vb3uW2VmISvV7mgLC6YSH9MoEQ5XkILUInfoJQi7sW9+tDgUzZUBAknICBMOLAKVJGiJ1ng8Pee0XbgnmWE=  ;
Subject: Re: Freeing a dynamic struct cdev
From: "James C. Georgas" <jgeorgas@rogers.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050806122108.4a458c68.rdunlap@xenotime.net>
References: <1123334776.29913.3.camel@Tachyon.home>
	 <20050806122108.4a458c68.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sat, 06 Aug 2005 15:26:18 -0400
Message-Id: <1123356380.13845.2.camel@Tachyon.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-06 at 12:21 -0700, Randy.Dunlap wrote:
> On Sat, 06 Aug 2005 09:26:15 -0400 James C. Georgas wrote:
> 
> > If I allocate a struct cdev using cdev_alloc(), what function do I call
> > to free it when I'm done with it?
> 
> Should be cdev_put(), which calls kobject_put(), which implements
> ref counting (using krefs), so that when the last reference is
> going away, the object will be removed.
> 
> ---
> ~Randy

cdev_put() is not an exported symbol in the fs/char_dev.c file. Should
it be?
-- 
James C. Georgas <jgeorgas@rogers.com>

