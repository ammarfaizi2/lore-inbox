Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWAGTQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWAGTQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbWAGTQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:16:07 -0500
Received: from [81.2.110.250] ([81.2.110.250]:62140 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030555AbWAGTPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:15:49 -0500
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sebastian <sebastian_ml@gmx.net>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060107140843.GA23699@section_eight.mops.rwth-aachen.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de>
	 <43BE24F7.6070901@triplehelix.org>
	 <20060106232522.GA31621@section_eight.mops.rwth-aachen.de>
	 <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com>
	 <20060107103901.GA17833@section_eight.mops.rwth-aachen.de>
	 <20060107105649.GT3389@suse.de>
	 <20060107112443.GA18749@section_eight.mops.rwth-aachen.de>
	 <20060107115340.GW3389@suse.de>
	 <20060107115449.GB20748@section_eight.mops.rwth-aachen.de>
	 <20060107115947.GY3389@suse.de>
	 <20060107140843.GA23699@section_eight.mops.rwth-aachen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 07 Jan 2006 19:18:17 +0000
Message-Id: <1136661497.3748.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-01-07 at 15:08 +0100, Sebastian wrote:
> You wrote about accessing the drive with SG_IO while using ide-cd. So it
> is possible to use scsi commands though using ide-cd? I can't find any
> documentation on that, though. Could you point me towards it? I can try
> to adapt cdparanoia.

In 2.6 yes. The SG_IO ioctl works on any block device fd. The commands
you can issue then depend upon the mode of opening. Some commands
require root, generally safe ones read or write access. 

Due to bugs still present in the block layer its also the only way to
reliably copy a data CD as well.

Alan

