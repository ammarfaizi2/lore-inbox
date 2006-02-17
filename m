Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWBQSNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWBQSNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWBQSND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:13:03 -0500
Received: from mail.gmx.de ([213.165.64.20]:28321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750773AbWBQSNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:13:01 -0500
X-Authenticated: #428038
Date: Fri, 17 Feb 2006 19:12:52 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060217181252.GB11340@merlin.emma.line.org>
Mail-Followup-To: "D. Hazelton" <dhazelton@enter.net>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <200602161742.26419.dhazelton@enter.net> <43F5B686.nail2VCA2A2OF@burner> <200602171502.20268.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602171502.20268.dhazelton@enter.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, D. Hazelton wrote:

> Says you. Since the SCSI system via /dev/hd* was just added in, IIRC, the 2.5 
> series kernel - at the same time ide-scsi was deprecated access via SG_IO 
> on /dev/hd* is the new method and not deprecated.

This is all information that libscg does not need to know. There are
only two models:

1. the old sg2 model before SG_IO was available, was to use write() and
read() on a /dev/sg* node.

2. the new sg3 model is do SG_IO on any device node no matter if /dev/hd,
/dev/sg or perhaps /dev/foobaz42 next year. /dev/sg* happened to be the
first to implement this, others followed suit, and more to come.

-- 
Matthias Andree
