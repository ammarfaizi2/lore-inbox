Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVFVEIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVFVEIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 00:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVFVEIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 00:08:09 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:34719 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262598AbVFVEIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 00:08:00 -0400
Date: Tue, 21 Jun 2005 21:07:55 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Anil kumar <anils_r@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "no version for struct_module: found" error
Message-Id: <20050621210755.4d074318.rdunlap@xenotime.net>
In-Reply-To: <20050622010432.49221.qmail@web32409.mail.mud.yahoo.com>
References: <20050622010432.49221.qmail@web32409.mail.mud.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005 18:04:32 -0700 (PDT) Anil kumar wrote:

| Hi,
| 
| I am loading an non-gpl module. I am getting error:
| "no version for struct_module found":tainted kernel.
| 
| Its for > 2.6.8 kernels.
| 
| I know that I get tainted kernel error when its not
| GPL, but what does the error "no version for
| struct_module found" mean?

That the kernel was built with CONFIG_MODVERSIONS=y but the
module was built with CONFIG_MODVERSIONS=n (i.e., without
symbol versioning information).

| How to get rid of this?

Build the kernel and module with the same config options.

| I checked the module.c under kernel dir, I guess I am
| getting this error for 
| if(!(tainted & TAINTED_FORCED_MODULE)...

Yes.

---
~Randy
