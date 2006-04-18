Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWDROZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWDROZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWDROZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:25:16 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:48319 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932195AbWDROZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:25:15 -0400
Subject: Re: [RFC] binary firmware and modules
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Masters <jonathan@jonmasters.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <35fb2e590604180616r33a05380p65c0e1c26ae276de@mail.gmail.com>
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <35fb2e590604180616r33a05380p65c0e1c26ae276de@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 16:25:27 +0200
Message-Id: <1145370327.10255.62.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

> > The attached patch introduces MODULE_FIRMWARE as one way of advertising
> > that a particular firmware file is to be loaded - it will then show up
> > via modinfo and could be used e.g. when packaging a kernel. I've also
> > given an example via the QLogic gla2xxx driver.
> 
> Ok. If nobody shouts today I'm going to suggest this go into 2.6.17. I
> think more ellaborate schemes will come up later, but we also need
> something usable out there now.

I like to see this in 2.6.17, too. I also think that it would be a good
idea if we can add a description to each firmware file. Like we do with
the module parameters.

> As others have pointed out, cunning schemes to hack how
> request_firmware et al work are all very well and good, but often we
> just don't know what firmware we'll need until runtime. Unless or
> until there's a good way to address that, I think modules will need to
> advertise every firmware and distros will have to package all possible
> firmwares, just in case.

And remember that request_firmware() is also used for overriding CIS
tables for PCMCIA cards.

Regards

Marcel


