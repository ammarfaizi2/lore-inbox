Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVAEBYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVAEBYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVAEBXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:23:53 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:30903 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262187AbVAEBUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:20:22 -0500
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1u0pwls1w.fsf@clusterfs.com>
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <m1u0pwls1w.fsf@clusterfs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104884106.24187.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 00:15:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 22:59, Nikita Danilov wrote:
> I don't think that CAP_SYS_ADMIN is proper capability for this:
> CAP_SYS_ADMIN is catch-all that should be used only when no other
> capability covers action being performed. In this case CAP_SYS_RESOURCE
> seems to be a better fit, after all __vm_enough_memory() controls access
> to a resource, plus file systems use CAP_SYS_RESOURCE to protect disk
> blocks reserved for "root".

Its a heuristic for "system process" and works rather well.
CAP_SYS_RESOURCE is about ignoring limits, this is about saving the
administrators backside.

