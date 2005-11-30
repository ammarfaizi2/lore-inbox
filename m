Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVK3MpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVK3MpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 07:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVK3MpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 07:45:18 -0500
Received: from mx1.suse.de ([195.135.220.2]:14826 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751203AbVK3MpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 07:45:18 -0500
Date: Wed, 30 Nov 2005 13:45:09 +0100
From: Andi Kleen <ak@suse.de>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130124508.GK19515@wotan.suse.de>
References: <20051130042118.GA19112@kvack.org> <438D4905.9F023405@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438D4905.9F023405@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your patch breaks all out-of-tree amd64 assembler code used in kernel. r10
> register is one of those registers that does not need to be preserved across
> function calls, and reserving that register for other purpose means that all
> assembler code using r10 in kernel must be rewritten. This is deeply
> unfunny.

Well, the changes should be minor.

> 
> Please don't apply Ben's patch. It is already bad enough having to deal with
> two incompatible calling conventions on 32 bit x86.

43KB .text savings are hard to argue against. There is no guarantee
for a stable kernel ABI. If you maintain out of tree code you 
will need to live with the occasional changes.

-Andi
