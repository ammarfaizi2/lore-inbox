Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWF0OBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWF0OBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWF0OBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:01:30 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:31165 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932289AbWF0OB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:01:29 -0400
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
	uninitialised data
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@osdl.org>, stsp@aknet.ru, linux-kernel@vger.kernel.org
In-Reply-To: <31382.1151413209@ocs3.ocs.com.au>
References: <31382.1151413209@ocs3.ocs.com.au>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 09:01:15 -0500
Message-Id: <1151416875.3340.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 23:00 +1000, Keith Owens wrote:
> AFAICR, the BSP is supposed to be logical cpu 0 on all architectures.
> Most architectures assign logical cpu 0 to the BSP, even if the BSP
> has
> a non-zero hard_smp_processor_id.  ia64 even has this

That's definitely not a requirement.  For systems like voyager whose
CPUs cannot be renumbered it makes no sense.  The original reason for
renumbering was that most CPU loops ran from 1 to max_cpu and therefore
worked better if the CPU map was dense.  However, I fixed that up long
ago so sparse CPU map traversal should be fine now.

James


