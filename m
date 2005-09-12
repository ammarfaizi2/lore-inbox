Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVILRaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVILRaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVILRaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:30:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14785 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932112AbVILRaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:30:23 -0400
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, ak@muc.de,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4325B6E3.9090503@adaptec.com>
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
	 <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
	 <20050911035621.87661.qmail@mail.muc.de> <1126446071.4831.5.camel@mulgrave>
	 <4325B6E3.9090503@adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 18:55:18 +0100
Message-Id: <1126547718.30449.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-12 at 13:12 -0400, Luben Tuikov wrote:
> > But my point was that we already have a mechanism for coping with this:
> > The scsi template parameterises some of these things (max sector size,
> > sg table elements, clustering, etc).
> 
> James, people have _already_ replied to your point, saying
> that they want to start with a _clean_ hardware model/interface.
> See Alan and Andi's emails.

There is a difference between worrying about stuff later and not
supporting existing things people expect to work.

> It is time SCSI Core started cleanly, especially now with SAS
> which will completely *replace* Parallel SCSI and IDE (for SATA).

You have to get from here to there, and do so without breaking anything
or making it untestable on the way. Going around the scsi limits rather
than fixing the current weaknesses may or may not be the right way but
it needs to occur in logical steps.

Alan
