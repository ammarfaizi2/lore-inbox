Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVBGWex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVBGWex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVBGWew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:34:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:30397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261291AbVBGWed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:34:33 -0500
Date: Mon, 7 Feb 2005 14:34:27 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Subject: Re: [PATCH] sys_chroot() hook for additional chroot() jails enforcing
Message-ID: <20050207143427.B469@build.pdx.osdl.net>
References: <1107814610.3754.260.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1107814610.3754.260.camel@localhost.localdomain>; from lorenzo@gnu.org on Mon, Feb 07, 2005 at 11:16:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Hernández García-Hierro (lorenzo@gnu.org) wrote:
> Attached you can find a patch which adds a new hook for the sys_chroot()
> syscall, and makes us able to add additional enforcing and security
> checks by using the Linux Security Modules framework (ie. chdir
> enforcing, etc).

If you want to make a change like this, collapse the
capable(CAP_SYS_CHROOT) check behind this hook, no point having two
outcalls from same call site.  What logic do you expect to put behind
the chroot() hook?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
