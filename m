Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVAXXYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVAXXYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVAXXYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:24:14 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:56464 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261670AbVAXXTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:19:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AnlVbG6W7DNTCn04V38yDwG4lH7TnokpPQAz8SNu5ACplEa7NhW8uMTQELupBQkuL2b2589xIPsXiq1BwUfrIvEUJ11p5ioxMUrWag+zRPq7f1QdsjqrSoA8q5FVyGTRr9r43JFj/VFK7ekPMlwjl1jlKmtgT9KD2VNOJxjcED4=
Message-ID: <9e47339105012415196a128899@mail.gmail.com>
Date: Mon, 24 Jan 2005 18:19:05 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: davidm@hpl.hp.com
Subject: Re: inter_module_get and __symbol_get
Cc: Keith Owens <kaos@ocs.com.au>, bgerst@didntduck.org,
       Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16885.31766.730042.408639@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16885.30810.787188.591830@napali.hpl.hp.com>
	 <30494.1106606658@ocs3.ocs.com.au>
	 <16885.31766.730042.408639@napali.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 14:52:06 -0800, David Mosberger
<davidm@napali.hpl.hp.com> wrote:
> Well, the only place that I know of where I (have to) care about
> inter_module*() is because of the DRM/AGP dependency.  I can't imagine

The DRM inter_module_XX dependency has been removed in 2.6.10. AGP
still exports inter_module_XX so that things like Nvidia/ATI drivers
will continue to work.

The last big use of inter_module_xx is in drivers/mtd in the M-systems
disk on a chip drivers.

-- 
Jon Smirl
jonsmirl@gmail.com
