Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWBSWig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWBSWig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWBSWig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:38:36 -0500
Received: from ozlabs.org ([203.10.76.45]:61877 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751105AbWBSWif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:38:35 -0500
Subject: Re: kbuild: Section mismatch warnings
From: Rusty Russell <rusty@rustcorp.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060219113630.GA5032@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org>
	 <20060217224702.GA25761@mars.ravnborg.org>
	 <20060219113630.GA5032@mars.ravnborg.org>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 09:38:35 +1100
Message-Id: <1140388715.2418.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 12:36 +0100, Sam Ravnborg wrote:
> The module parameter warning are still pending - I hope Rusty will
> comment on yhe suggested patch to use __initdata in the moduleparam
> macro.

kernel/params.c's param_sysfs_setup will have to make a copy if you do
this.  At the moment it keeps the original structure around.

Hope that helps!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

