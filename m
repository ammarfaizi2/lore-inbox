Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTFJNMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTFJNMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:12:40 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:38404 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262636AbTFJNMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:12:38 -0400
Date: Tue, 10 Jun 2003 14:26:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?P=E1sztor_Szil=E1rd?= <silicon@inf.bme.hu>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
Message-ID: <20030610142614.A25666@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?P=E1sztor_Szil=E1rd?= <silicon@inf.bme.hu>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	Adrian Bunk <bunk@fs.tum.de>
References: <20030608175850.A9513@infradead.org> <Pine.GSO.4.00.10306101347450.1700-100000@kempelen.iit.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.00.10306101347450.1700-100000@kempelen.iit.bme.hu>; from silicon@inf.bme.hu on Tue, Jun 10, 2003 at 01:55:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 01:55:22PM +0200, Pásztor Szilárd wrote:
> The drivers are used by some hundreds of cards today but we tell users to
> get the small kernelpatch from www.itc.hu and the patch, among other things,
> exports proc_get_inode. There was a process to integrate the patch into the
> mainstream kernel last year but, due to lack of time on my part, it was
> suspended. I hope to be able to pick the line up again and clean things up.

So what about fixing it instead?  The usage of proc_get_inode is broken
and so is the whole profs mess in the comx driver.  If you want to keep
the API you need to add a ramfs-style filesystem instead of abusing
procfs.

