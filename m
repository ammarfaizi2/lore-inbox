Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267260AbTGOLqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbTGOLqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:46:11 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:2754 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S267260AbTGOLqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:46:08 -0400
Subject: Re: sizeof (siginfo_t) problem
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF688246EA.0B58B996-ONC1256D64.00411F64-C1256D64.0041CE23@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 15 Jul 2003 13:58:46 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 15/07/2003 13:59:47
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This means it does not work on any kernels so far, if we don't add a pad
> to the kernel and just fix __ARCH_SI_PREAMBLE_SIZE on s390x, then GCC
> will suddenly work with all newer kernels but will never work with older
> kernels.

This is a kernel bug and I'm inclined to say that this has to be fixed in
the kernel and only there. If it didn't work at all so far nobody will
complain that it suddenly works with the kernel fix. It is an ABI change
but for an ABI that didn't work so far. I don't see a problem with the
simple fix to use __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int)) for s390x.

blue skies,
   Martin


