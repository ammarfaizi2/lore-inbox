Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUIIQfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUIIQfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUIIQfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:35:47 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:6578 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S266236AbUIIQfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:35:31 -0400
Subject: Re: [patch] update: _working_ code to add device+inode check to
	ipt_owner.c
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1094747347.22014.94.camel@moss-spartans.epoch.ncsc.mil>
References: <20040909162200.GB9456@lkcl.net>
	 <1094747347.22014.94.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1094747615.22014.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 12:33:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 12:29, Stephen Smalley wrote:
> SELinux already uses d_path when it can when generating audit messages
> (but always includes device and inode information); try reading the
> code.  But a vfsmount is often not available to it at the point of a
> permission check.

But note that you can get more pathname information by enabling the
kernel syscall auditing support, i.e. boot with audit=1.  Then, whenever
SELinux generates an audit message during syscall processing, the audit
framework will also generate an audit message on syscall exit that
includes parameter information, including the supplied pathname (for
what it is worth).  Those audit messages can be tied together based on
serial number.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

