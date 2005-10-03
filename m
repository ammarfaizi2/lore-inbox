Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVJCP5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVJCP5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVJCP5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:57:09 -0400
Received: from [81.2.110.250] ([81.2.110.250]:53956 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932323AbVJCP5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:57:08 -0400
Subject: Re: [patch] drivers/ide/pci/alim15x3.c SMP fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20051003065032.GA23777@elte.hu>
References: <20050901072430.GA6213@elte.hu>
	 <1125571335.15768.21.camel@localhost.localdomain>
	 <20051003065032.GA23777@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 17:24:48 +0100
Message-Id: <1128356688.26992.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 08:50 +0200, Ingo Molnar wrote:
> so perhaps part of the solution would be to do the initialization under 
> the IDE lock, via the patch below? It boots fine on my box so the basic 
> codepaths seem to be OK. Then the retuning codepaths need to be checked 
> to make sure they are holding the IDE lock.

The initialisation can take several seconds. Some controller paths may
also sleep so you would need to do a full audit first.

Alan

