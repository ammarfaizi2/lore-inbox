Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269994AbUJHPNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbUJHPNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270005AbUJHPNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:13:05 -0400
Received: from gate.firmix.at ([80.109.18.208]:50870 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S269994AbUJHPNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:13:01 -0400
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from
	inside kernel
From: Bernd Petrovitsch <bernd@firmix.at>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20041008151837.GI5551@lkcl.net>
References: <20041008130442.GE5551@lkcl.net>
	 <41669DE0.9050005@didntduck.org>  <20041008151837.GI5551@lkcl.net>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1097248370.26463.0.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Fri, 08 Oct 2004 17:12:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 16:18 +0100, Luke Kenneth Casson Leighton wrote:
> On Fri, Oct 08, 2004 at 10:02:08AM -0400, Brian Gerst wrote:
> > Luke Kenneth Casson Leighton wrote:
> > >could someone kindly advise me on the location of some example code in
> > >the kernel which calls one of the userspace system calls from inside the
> > >kernel?
> > >
> > >alternatively if this has never been considered before, please could
> > >someone advise me as to how it might be achieved?
> > 
> > What are you trying to do?  
> 
>  call sys_rename, sys_pread, sys_create, sys_mknod, sys_rmdir
>  etc. - everything that does file access.
> 
> > In most cases needing to use syscalls from 
> > within the kernel is an indication of a design flaw.  
> 
>  in this case it's an attempt to avoid cutting and pasting
>  the entire contents of sys_rename, sys_pread, sys_this,
>  sys_that, removing the first couple and last few lines (that
>  do copy_from_user) and replacing the arguments with either
>  a dentry or a kernel-side char* instead of an __user char*.
> 
>  my alternative is to patch every single vfs-related sys_* in fs/*.c to
>  be able to "plug in" to these functions.

Why not implement it in user-space?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

