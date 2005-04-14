Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVDNBL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDNBL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 21:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVDNBLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 21:11:55 -0400
Received: from quechua.inka.de ([193.197.184.2]:39357 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261230AbVDNBLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 21:11:54 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050413231044.GA31005@gondor.apana.org.au>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DLstb-0008UO-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 14 Apr 2005 03:11:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050413231044.GA31005@gondor.apana.org.au> you wrote:
> The ssh keys are *encrypted* in the swap when dmcrypt is used.
> When the swap runs over dmcrypt all writes including those from
> swsusp are encrypted.

The problem is that after an resume the running system has access to the
swap, because the key is recoverd. And the left over hybernation data in the
swap can be read by the running kernel because the swap key is restored.
This is not an attack against a notebook in hybernaion, but an attack
against a running system with non-wiped bybernation leftovers - not critical
to me but an possible point of interest.

Gruss
Bernd
