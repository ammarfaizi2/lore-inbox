Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbULFOD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbULFOD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbULFODZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:03:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34274 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261521AbULFOCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:02:38 -0500
Date: Mon, 6 Dec 2004 14:55:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6: drivers/md/dm-io.c partially copies bio.c
Message-ID: <20041206135539.GZ10498@suse.de>
References: <20041206120941.GB7250@stusta.de> <200412060748.51047.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412060748.51047.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06 2004, Kevin Corry wrote:
> Hi Adrian,
> 
> On Monday 06 December 2004 6:09 am, Adrian Bunk wrote:
> > drivers/md/dm-io.c copies functionality from bio.c .
> >
> > Is there a specific reason why you don't simply use the functionality
> > bio.c provides?
> 
> Can you give some specific examples of the functionality you think is 
> duplicated? Meanwhile, I'll take a look and see if I can explain any code 
> overlaps.

Ah come on Kevin, a 2 second glance shows lots of uneccesary
duplication. Basically only the concept of the bio_set is not duplicated
in the first many lines, you even set up matching slabs.

How was that ever accepted for merging?

-- 
Jens Axboe

