Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTLBQcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTLBQcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:32:24 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:35812 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262360AbTLBQcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:32:22 -0500
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Greg Stark <gsstark@mit.edu>, Erik Steffl <steffl@bigfoot.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>
	<3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv>
	<3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com>
	<87n0abbx2k.fsf@stark.dyndns.tv>
	<20031202055336.GO1566@mis-mike-wstn.matchmail.com>
	<20031202055852.GP1566@mis-mike-wstn.matchmail.com>
In-Reply-To: <20031202055852.GP1566@mis-mike-wstn.matchmail.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 02 Dec 2003 11:31:45 -0500
Message-ID: <87zneb9o5q.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Fedyk <mfedyk@matchmail.com> writes:

> > Libata, uses the scsi system instead of the existing ide layer because many
> > new sata controllers are using an interface that is very similair to scsi
> > (much like atapi).

Now I have a different question. Does the scsi-like SATA interface include tcq?

Because one of the long-standing issues with IDE drives and Postgres is the
fact that even after issuing an fsync the data may be sitting in the drive's
buffer. This doesn't happen with SCSI because the drives aren't forced to lie
about the data being on disk in order to handle subsequent requests. Turning
off write-caching on IDE drives absolutely destroys performance.

Do the new SATA drives and controllers provide a solution to this?

-- 
greg

