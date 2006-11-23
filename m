Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933675AbWKWNQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933675AbWKWNQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933683AbWKWNQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:16:21 -0500
Received: from mail.axxeo.de ([82.100.226.146]:4224 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S933675AbWKWNQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:16:20 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: David Chinner <dgc@sgi.com>
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Date: Thu, 23 Nov 2006 14:16:02 +0100
User-Agent: KMail/1.9.1
Cc: David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
       chatz@melbourne.sgi.com, linux-kernel@vger.kernel.org, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com> <20061122.201013.112290046.davem@davemloft.net> <20061123070837.GV11034@melbourne.sgi.com>
In-Reply-To: <20061123070837.GV11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611231416.03387.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

David Chinner schrieb:
> If the softirqs were run on a different stack, then a lot of these
> problems would go away (29 of the 35 reported overflows had softirqs
> running) and we'd be much more likely to get XFS to run reliably on
> 4k stacks...

Ok, that seem like another approach. What about putting your allocation slowpath 
in a kernel thread. They might have more stack available.

This is inferior to the complexity reduction suggested from the kernel people,
but if you cannot reduce complexity anymore this might work, too.


Regards

Ingo Oeser
