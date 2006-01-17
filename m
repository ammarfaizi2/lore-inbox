Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWAQOhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWAQOhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWAQOhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:37:07 -0500
Received: from mxsf06.cluster1.charter.net ([209.225.28.206]:44673 "EHLO
	mxsf06.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932084AbWAQOhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:37:05 -0500
X-IronPort-AV: i="3.99,376,1131339600"; 
   d="scan'208"; a="2031604563:sNHT17873180"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17357.271.619918.45917@smtp.charter.net>
Date: Tue, 17 Jan 2006 09:37:03 -0500
From: "John Stoffel" <john@stoffel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 001 of 5] md: Split disks array out of raid5 conf structure so it is easier to grow.
In-Reply-To: <1060117065614.27831@suse.de>
References: <20060117174531.27739.patches@notabene>
	<1060117065614.27831@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "NeilBrown" == NeilBrown  <neilb@suse.de> writes:

NeilBrown> Previously the array of disk information was included in
NeilBrown> the raid5 'conf' structure which was allocated to an
NeilBrown> appropriate size.  This makes it awkward to change the size
NeilBrown> of that array.  So we split it off into a separate
NeilBrown> kmalloced array which will require a little extra indexing,
NeilBrown> but is much easier to grow.

Neil,

Instead of setting mddev->private = NULL, should you be doing a kfree
on it as well when you are in an abort state?

John
