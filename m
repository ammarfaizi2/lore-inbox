Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTEMRrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbTEMRrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:47:09 -0400
Received: from pat.uio.no ([129.240.130.16]:54961 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262465AbTEMRrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:47:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.12944.741393.595356@charged.uio.no>
Date: Tue, 13 May 2003 19:59:44 +0200
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <20030513173801.GA2763@suse.de>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<shswugvjcy9.fsf@charged.uio.no>
	<20030513135756.GA676@suse.de>
	<16065.3159.768256.81302@charged.uio.no>
	<20030513152228.GA4388@suse.de>
	<16065.4109.129542.777460@charged.uio.no>
	<20030513154741.GA4511@suse.de>
	<16065.5911.55131.430734@charged.uio.no>
	<20030513173801.GA2763@suse.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@codemonkey.org.uk> writes:

     > On Tue, May 13, 2003 at 06:02:31PM +0200, Trond Myklebust
     > wrote:
    >> Then I'm confused as to what you are saying. Are we talking
    >> about a full NFS server crash or just a temporary 'server not
    >> responding' situation? Does NFS over TCP fix it, for instance?

     > Just to keep you busy..  I had thought NFS over TCP fixed
     > it. It rang for a lot longer (around 50 minutes), and then did
     > the following..  Looks like a different bug to my untrained
     > eye.

Nah. Looks like the same thing: mmapped writes followed by truncate.
TCP is likely to change the timings a bit (reliable transport means
that the race between out-of-order write and truncate is smaller, but
it is still there.

Cheers,
  Trond
