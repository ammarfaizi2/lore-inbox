Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTI0NZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 09:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTI0NZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 09:25:51 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:8197 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262444AbTI0NZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 09:25:50 -0400
Subject: Re: [PATCH][2.6] fix atp870u boot oops
From: James Bottomley <James.Bottomley@steeleye.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Eric Balsa <eric@onewest.net>
In-Reply-To: <Pine.LNX.4.53.0309270302110.16940@montezuma.fsmlabs.com>
References: <001701c3845e$f3e4b470$fad11341@corporate.onewest.net> 
	<Pine.LNX.4.53.0309270302110.16940@montezuma.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 Sep 2003 08:25:33 -0500
Message-Id: <1064669135.2002.1.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-27 at 04:27, Zwane Mwaikambo wrote:
> The driver's probe function accesses uninitialised data. I also made it 
> use pci_get_device instead of pci_find_device to bump the refcount on the 
> pci devices it finds.

I don't suppose you'd like to fix this properly?  i.e. convert the
driver to the sysfs based pci probing infrastructure and remove its
dependence on MAX_ATP arrays?

James


