Return-Path: <linux-kernel-owner+w=401wt.eu-S1753730AbXAATKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbXAATKT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbXAATKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:10:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53635 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712AbXAATKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:10:17 -0500
Date: Mon, 1 Jan 2007 14:10:15 -0500
From: Dave Jones <davej@redhat.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Sparse 0.2 warnings from {asm,net}/checksum.h
Message-ID: <20070101191015.GB20443@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tilman Schmidt <tilman@imap.cc>,
	LKML <linux-kernel@vger.kernel.org>
References: <45991971.90605@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45991971.90605@imap.cc>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 03:23:45PM +0100, Tilman Schmidt wrote:
 > With sparse 0.2, my previously sparse-clean driver generates the
 > following warnings:
 > 
 > include/asm/checksum.h:182:6: warning: symbol 'sum' shadows an earlier one
 > include/asm/checksum.h:178:28: originally declared here
 > include/net/checksum.h:33:6: warning: symbol 'sum' shadows an earlier one
 > include/net/checksum.h:31:27: originally declared here
 > 
 > Architecture is i386. The lines referred to are in the functions
 > csum_and_copy_to_user() and csum_and_copy_from_user(), but I
 > don't see why sparse would emit such a warning for that code.

It's complaining about the 'sum' declaration in __range_not_ok
used by access_ok(), which shadows the variable declared in
the prototype of the functions you mention.

		Dave

-- 
http://www.codemonkey.org.uk
