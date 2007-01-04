Return-Path: <linux-kernel-owner+w=401wt.eu-S964862AbXADOEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbXADOEm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 09:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbXADOEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 09:04:42 -0500
Received: from sophia.inria.fr ([138.96.64.20]:49245 "EHLO sophia.inria.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964862AbXADOEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 09:04:41 -0500
X-Greylist: delayed 2516 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 09:04:41 EST
Message-ID: <459D095E.4050306@yahoo.fr>
Date: Thu, 04 Jan 2007 15:04:14 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Handle error in sync_sb_inodes()
References: <45958E4F.5080105@yahoo.fr>	<20070102132645.264d2b89.akpm@osdl.org>	<459C2E6D.2040406@yahoo.fr> <20070103145655.c6e0963d.akpm@osdl.org>
In-Reply-To: <20070103145655.c6e0963d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (sophia.inria.fr [138.96.64.20]); Thu, 04 Jan 2007 15:04:14 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> There's a lot of sloppiness in there.  Do these two patches fix things up?
>   

Still no luck :-(
You managed to propagate the return value up to the
highest level (sync()), but as it's "void sync()" the return
value is dropped.
When msync() comes after it finds nothing in the mapping
flags.

Cheers.

-- 
Guillaume

