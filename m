Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVCAXyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVCAXyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVCAXyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:54:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38598 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262126AbVCAXyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:54:31 -0500
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050228192001.GA14221@apps.cwi.nl>
References: <20050228192001.GA14221@apps.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109721162.15795.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Mar 2005 23:52:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-02-28 at 19:20, Andries Brouwer wrote:
> One such case is the mtrr code, where struct mtrr_ops has an
> init field pointing at __init functions. Unless I overlook
> something, this case may be easy to settle, since the .init
> field is never used.

The failure to invoke the ->init operator appears to be the bug.

