Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265439AbTFXAR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265450AbTFXAR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:17:28 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:48328 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265439AbTFXARV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:17:21 -0400
Date: Mon, 23 Jun 2003 17:31:24 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Luis Miguel Garcia <ktech@wanadoo.es>, linux-kernel@vger.kernel.org
Subject: Re: Kernel & BIOS return differing head/sector geometries
Message-ID: <20030623173124.A2025@google.com>
References: <20030624010906.08ad32f3.ktech@wanadoo.es> <20030624013908.B1133@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030624013908.B1133@pclin040.win.tue.nl>; from aebr@win.tue.nl on Tue, Jun 24, 2003 at 01:39:08AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 01:39:08AM +0200, Andries Brouwer wrote:
> Linux does not use the BIOS, and does not use CHS either, so geometry is
> totally and completely irrelevant to Linux.

Is that also true for 2.2?  I've had problems where large drives (60+G)
do these geometry tricks, and if I don't force the geometry to what I
want, fdisk (actually, sfdisk, dunno about fdisk) doesn't see the
entire drive.

Sometimes the BIOS doesn't report the specific geometry that the kernel
detects means "LBA" (I think this depends partly on drive firmware) and 
then the kernel writes out some goofy geometry to the partition table
(I assume kernel geometry info is kept there?) and again I have problems
accessing the entire drive.

Also, if I later change the geometry, the previous partition table seems
to become incorrect.  This one really confuses me, shouldn't the partition
table be indexed by sectors?

Anyway, it's been a very long time since I've worked directly on this
problem, so lots of my characterizations may be wrong.  But I do know
that we force the geometry to specific values in our install, to combat
specific problems we've encountered.

/fc
