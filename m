Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWGHC2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWGHC2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 22:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWGHC2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 22:28:03 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:45013 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932488AbWGHC2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 22:28:02 -0400
Date: Fri, 7 Jul 2006 22:22:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: ext4 features
To: Theodore Tso <tytso@mit.edu>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Bill Davidsen <davidsen@tmr.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607072225_MC3-1-C46B-34C5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060707195223.GA12301@thunk.org>

On Fri, 7 Jul 2006 15:52:23 -0400, Theodore Tso wrote:

> Not four times a day, but probably once a month or two it would be a
> *very* good idea to do periodic sweeps of files to make sure the hard
> drive hasn't corrupted the files out from under you.  If you have 20+
> TB of data, the probability of silent data corruption starts going up.
> That would be justification for storing the checksum in the inode or
> in the EA of the file, with the kernel automatically clearing it if
> the file was *deliberately* changed.  The goal is to detect the disk
> silently changing the data for you, free of charge....

Per-extent checksums on ext4 might work better.

        -  If you only changed a small part of a file the majority of
           checksums would still be valid.

        -  On a file with 31K of data in a 128K extent, checksumming
           the wasted space might cause false positives but it would be
           OK because that would still be actual on-disk corruption.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
