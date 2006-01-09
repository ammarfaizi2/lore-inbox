Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWAIROS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWAIROS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWAIROR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:14:17 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:49938 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964883AbWAIROR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:14:17 -0500
Date: Mon, 9 Jan 2006 18:14:11 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Bernd Petrovitsch <bernd@firmix.at>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Message-ID: <20060109171411.GB67773@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Oliver Neukum <oliver@neukum.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Bernd Petrovitsch <bernd@firmix.at>,
	Robert Hancock <hancockr@shaw.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5t06S-7nB-15@gated-at.bofh.it> <1136824149.5785.75.camel@tara.firmix.at> <1136824880.9957.55.camel@mindpipe> <200601091753.36485.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601091753.36485.oliver@neukum.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 05:53:35PM +0100, Oliver Neukum wrote:
> Does the Windows Explorer draw icons based only on name and metadata?

>From what I can see it does icons on non-executable entirely based on
the extension and nothing else on the first pass.  Executables are
looked inside for an icon (and there seems to be cache effects at
times, especially visible on the desktop).  Then for images a second
pass generates icons depending on the contents (with, once again, a
cache hidden somewhere).

Not a bad strategy, too.  Doing a file(1) on everything can only be
slow given the random disk accesses it generates.  Maybe a file(1) as
a _second_ pass would work.

  OG.
