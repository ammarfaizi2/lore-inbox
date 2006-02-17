Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWBQMBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWBQMBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 07:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWBQMBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 07:01:23 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:53635 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1750710AbWBQMBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 07:01:23 -0500
Date: Fri, 17 Feb 2006 13:01:23 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dhazelton@enter.net, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060217.115403.7981.albireo@ucw.cz>
References: <43EB7BBA.nailIFG412CGY@burner> <20060216115204.GA8713@merlin.emma.line.org> <43F4BF26.nail2KA210T4X@burner> <200602161742.26419.dhazelton@enter.net> <43F5B686.nail2VCA2A2OF@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F5B686.nail2VCA2A2OF@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Sorry, the way to access SCSI generic via /dev/hd* is deprecated.

By whom?

> ir removed, then a clean and orthogonal way of accessing SCSI in a generic
> way is removed from Linux. If Linux does nto care about orthogonality of 
> interfaces, this is a problem of the people who are responbile for the related
> interfaces.

You open any SCSI device, you do SG_IO on it. What is non-orthogonal in that?

Yes, I agree with you that it's hard to do device discovery, but discovering
devices is completely orthogonal to doing I/O in them and it's also not
a problem specific to SCSI devices at all. Hence we want to find a general
solution suitable for *all* devices and that's what sysfs, udev and HAL are
for. They might have some rough edges yet, but they definitely solve the
right problem.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"In theory, practice and theory are the same, but in practice they are different." -- Larry McVoy
