Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVBGTMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVBGTMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVBGTMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:12:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:13975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261245AbVBGTMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:12:39 -0500
Date: Mon, 7 Feb 2005 11:12:35 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Filesystem linking protections
Message-ID: <20050207111235.Y24171@build.pdx.osdl.net>
References: <1107802626.3754.224.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1107802626.3754.224.camel@localhost.localdomain>; from lorenzo@gnu.org on Mon, Feb 07, 2005 at 07:57:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Hernández García-Hierro (lorenzo@gnu.org) wrote:
> This patch adds two checks to do_follow_link() and sys_link(), for
> prevent users to follow (untrusted) symlinks owned by other users in
> world-writable +t directories (i.e. /tmp), unless the owner of the
> symlink is the owner of the directory, users will also not be able to
> hardlink to files they do not own.
> 
> The direct advantage of this pretty simple patch is that /tmp races will
> be prevented.

The disadvantage is that it can break things and places policy in the
kernel.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
