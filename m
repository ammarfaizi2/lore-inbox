Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbSLSBfI>; Wed, 18 Dec 2002 20:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbSLSBfI>; Wed, 18 Dec 2002 20:35:08 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:34823
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267455AbSLSBfH>; Wed, 18 Dec 2002 20:35:07 -0500
Subject: Re: 15000+ processes -- poor performance ?!
From: Robert Love <rml@tech9.net>
To: David Lang <dlang@diginsite.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212181717510.7848-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0212181717510.7848-100000@dlang.diginsite.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040262178.855.106.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 20:42:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 20:20, David Lang wrote:
> Ok, I wasn't sure of the cause, but I've seen this as far back as 2.2 I
> had a machine trying to run 2000 processes under 2.2 and 2.4.0 (after
> upping the 2.2 kernel limit) and top would cost me ~40% throughput on the
> machine (while claiming it was useing ~5% of the CPU)

Yah a lot of it is like William is saying... you just do not want to
read multiple files for each process in /proc when you have a kajillion
processes, and that is what top does.  Over and over.

Work has gone into 2.5 to make this a lot better.. If you use threads
with NPTL in 2.5, a lot of this is resolved, since the sub-threads will
not show up in as /proc/#/ entries.

	Robert Love

