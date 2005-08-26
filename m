Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbVHZPGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVHZPGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVHZPGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:06:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53659 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965069AbVHZPGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:06:23 -0400
Subject: Re: [PATCH 2.6.13-rc7 2/2] New Syscall: set rlimits of any process
	(reworked)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: e8607062@student.tuwien.ac.at
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1125027581.6394.11.camel@w2>
References: <1125027277.6394.8.camel@w2>  <1125027581.6394.11.camel@w2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 16:34:33 +0100
Message-Id: <1125070473.4958.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-26 at 05:39 +0200, Wieland Gmeiner wrote:
> This is the second of two patches, it implements the setprlimit()
> syscall.
> 
> Implementation: This patch provides a new syscall setprlimit() for
> writing a given process resource limits for i386. Its implementation
> follows closely the setrlimit syscall. It is given a pid as an


While looking at this have you considered 64bit rlimits on a 32bit box.
If a new API is going to be added it would be a good time to fix the
fact that some limits should be 64bit nowdays and have 

setrlimit()		existing legacy/standards API
setprlimit64()		with size fixed and ability to specify process

Any thoughts on this ?





