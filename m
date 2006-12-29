Return-Path: <linux-kernel-owner+w=401wt.eu-S932692AbWL2E4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWL2E4i (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 23:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWL2E4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 23:56:38 -0500
Received: from fe02.tochka.ru ([62.5.255.22]:55956 "EHLO umail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932674AbWL2E4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 23:56:37 -0500
From: Alex Tomas <alex@clusterfs.com>
To: David Chinner <dgc@sgi.com>
Cc: Alex Tomas <alex@clusterfs.com>, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] delayed allocation for ext4
Organization: CFS
References: <m37iwjwumf.fsf@bzzz.home.net>
	<20061223033123.GL44411608@melbourne.sgi.com>
	<m3zm9etomy.fsf@bzzz.home.net>
	<20061229025246.GO44411608@melbourne.sgi.com>
X-Comment-To: David Chinner
Date: Fri, 29 Dec 2006 07:56:22 +0300
In-Reply-To: <20061229025246.GO44411608@melbourne.sgi.com> (David Chinner's
	message of "Fri\, 29 Dec 2006 13\:52\:46 +1100")
Message-ID: <m37iwbqozt.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> David Chinner (DC) writes:

 DC> So that mean's we'll have 2 separate mechanisms for marking
 DC> pages as delalloc. XFS uses the BH_delay flag to indicate
 DC> that a buffer (block) attached to the page is using delalloc.
 >> 
 >> well, for blocksize=pagesize we can save 56 bytes on every page.

 DC> Sure, but it means that ext4 w/ delalloc won't work on lots of
 DC> machines....

it does not currenly. but I'm going to implement that. not sure
whether it's worth to have two different codepaths for
block size=page size and block size < page size.

 DC> FWIW, how does this mechanism deal with block size < page size?
 DC> Don't you have to track delalloc on a block basis rather than
 DC> a page basis?
 >> 
 >> I'm still thinking how better to deal with that w/o much code duplication.

 DC> Code duplication in ext4, or across all filesystems?

given what Andrew said about moving the code into VFS, it's more
about all filesystems.

thanks, Alex
