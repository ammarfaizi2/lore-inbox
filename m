Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTFJNno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTFJNno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:43:44 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:59396 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262497AbTFJNnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:43:41 -0400
Date: Tue, 10 Jun 2003 14:57:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?P=E1sztor_Szil=E1rd?= <silicon@inf.bme.hu>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
Message-ID: <20030610145721.A27349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?P=E1sztor_Szil=E1rd?= <silicon@inf.bme.hu>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	Adrian Bunk <bunk@fs.tum.de>
References: <20030610142614.A25666@infradead.org> <Pine.GSO.4.00.10306101549360.13214-100000@kempelen.iit.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.00.10306101549360.13214-100000@kempelen.iit.bme.hu>; from silicon@inf.bme.hu on Tue, Jun 10, 2003 at 03:51:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 03:51:09PM +0200, Pásztor Szilárd wrote:
> Is the case the same with the SCSI drivers, IDE drivers, network core,
> filesystems and everything that creates directories and file entries in
> procfs?

No.  The problem with comx is that unlike other driver it doesn't
not use the published procfs API but instead tries to implemented
half of an own filesystem abusing procfs infrastructure.

