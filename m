Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbTGISyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268583AbTGISyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:54:31 -0400
Received: from pat.uio.no ([129.240.130.16]:18163 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268577AbTGISy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:54:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16140.26693.72927.451259@charged.uio.no>
Date: Wed, 9 Jul 2003 21:08:53 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
In-Reply-To: <20030709190531.GF15293@gtf.org>
References: <20030709133109.A23587@infradead.org>
	<Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
	<16140.24595.438954.609504@charged.uio.no>
	<200307092041.42608.m.c.p@wolk-project.de>
	<16140.25619.963866.474510@charged.uio.no>
	<20030709190531.GF15293@gtf.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jeff Garzik <jgarzik@pobox.com> writes:

     > s/replacing/adding/

Revert ;-)

     > A new ->direct_IO2 hook would be an addition, so you really
     > want to simply add another feature flag.

You missed the point. This is *instead* of ->direct_IO2. It's only
purpose would be to distinguish between the old

 int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);


and the new

 int (*direct_IO)(int, struct file *, struct kiobuf *, unsigned long, int);

Cheers,
  Trond
