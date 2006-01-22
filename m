Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWAVW5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWAVW5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWAVW5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:57:16 -0500
Received: from mail.suse.de ([195.135.220.2]:35761 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932313AbWAVW5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:57:15 -0500
From: Neil Brown <neilb@suse.de>
To: "John Stoffel" <john@stoffel.org>
Date: Mon, 23 Jan 2006 09:57:05 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17364.3521.662774.431030@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 001 of 5] md: Split disks array out of raid5 conf structure so it is easier to grow.
In-Reply-To: message from John Stoffel on Friday January 20
References: <20060117174531.27739.patches@notabene>
	<1060117065614.27831@suse.de>
	<17357.271.619918.45917@smtp.charter.net>
	<17358.56490.127364.327688@cse.unsw.edu.au>
	<17361.44149.200493.916170@smtp.charter.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday January 20, john@stoffel.org wrote:
> Though now that I look at it, don't we have a circular reference
> here?  Let me quote the code section, which starts of with where I was
> confused: 
..
> 
> Now we seem to end up with:
> 
> 	mddev->private = conf;
> 	conf->mddev = mddev;
> 

This is simply to related structures each holding a reference to the
other.  It's like the child pointing to the parent, and the parent
pointing to the child, which you get all the time.

NeilBrown
