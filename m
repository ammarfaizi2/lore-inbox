Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTDYLiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTDYLiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:38:22 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:55488 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263876AbTDYLiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:38:21 -0400
Subject: Re: [RFC/PATCH] IDE Power Management try 1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Alexander Atanasov <alex@ssi.bg>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030425103342.GJ1012@suse.de>
References: <1051189194.13267.23.camel@gaston> <3EA90176.2080304@ssi.bg>
	 <20030425103342.GJ1012@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051271419.14994.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 13:50:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> There are already lots of "INTERNAL" - basically take your pick from all
> the ones you quote above (DRIVE_TASK, DRIVE_CMD, DRIVE_TASKFILE - it's a
> MESS). A power management special request makes sense to me.

Ok, well, if you prefer this way it's ok with me too ;) Though for
sanity, it would have made sense then to breakup the request type into
a major type (BIO, INTERNAL, POWER, ...) and a minor that is major-type
dependant (READ/WRITE/BARRIER for BIO, TASKFILE,ERROR,... for INTERNAL,
and SUSPEND/RESUME for POWER for example).

Ben.

