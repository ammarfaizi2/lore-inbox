Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWDFM50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWDFM50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 08:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWDFM50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 08:57:26 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:23285 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751242AbWDFM5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 08:57:25 -0400
Subject: Re: Q on audit, audit-syscall
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: Valdis.Kletnieks@vt.edu, Kyle Moffett <mrmacman_g4@mac.com>,
       Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200604052147.k35LlOpK010229@wildsau.enemy.org>
References: <200604052147.k35LlOpK010229@wildsau.enemy.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 06 Apr 2006 09:01:48 -0400
Message-Id: <1144328508.6176.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-05 at 23:47 +0200, Herbert Rosmanith wrote:
> > happened, this is what you want.  If you want to apply a security restriction,
> > you want to look at SELinux or perhaps a custom LSM.  If you have some
>                                          ^^^^^^^^^^^^
> 
> the idea already crossed my mind. but I rather start bottom up: LSM depends
> on CONFIG_AUDIT* (this is correct, isn't it?), so I examine AUDIT first. if
> AUDIT doesnt support what I need, I continue with LSM.

SELinux has a dependency on CONFIG_AUDIT these days because it uses the
audit system to log permission denials (originally just used printk, but
switched to the audit system when it was mainstreamed), but SELinux
doesn't depend on CONFIG_AUDIT for the actual access control checking
and enforcement.  SELinux just feeds data to the audit system for such
logging; it doesn't take any inputs from the audit system.

-- 
Stephen Smalley
National Security Agency

