Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWDXOTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWDXOTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWDXOTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:19:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17595 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750763AbWDXOTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:19:25 -0400
Subject: RE: Problems with EDAC coexisting with BIOS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ong, Soo Keong" <soo.keong.ong@intel.com>
Cc: "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
In-Reply-To: <C1989F6360C8E94B9645F0E4CF687C08C1E9FB@pgsmsx412.gar.corp.intel.com>
References: <C1989F6360C8E94B9645F0E4CF687C08C1E9FB@pgsmsx412.gar.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 15:29:39 +0100
Message-Id: <1145888979.29648.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 22:15 +0800, Ong, Soo Keong wrote:
> To me, periodical is not a good design for error handling, it wastes
> transaction bandwidth that should be used for other more productive
> purposes.

The periodical choice is mostly down to the brain damaged choice of NMI
as the viable alternative, which is as good as 'not usable'

> It is more appropriate to have single handler, either OS or BIOS.

Agreed but then the BIOS must provide that service to the OS reliably
and efficiently so that users can build that service into their system
wide error management and control processes.

> In general, the errors handler connect the errors to the interrupt or
> interrutps. The handler should undhide (if it s hideable) the error
> controller and read its registers upon interrupt, then carry out
> appropriate actions to handle the erros.

Actually I am dubious that the error handler can do that. If the OS
kernel just issued the first half of a config cycle what occurs when the
SMI tries to play with PCI config space ? 


