Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVC1IDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVC1IDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 03:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVC1IDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 03:03:37 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:64524 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S261281AbVC1IDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 03:03:33 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Tux <nclarke@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <470aa293050326023710e7b892@mail.gmail.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <470aa293050326023710e7b892@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 10:03:30 +0200
Message-Id: <1111997010.896.13.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 10:37 +0000, Tux wrote:
> I'm confused, are hard limits to RLIMIT_NPROC imposed on services
> spawned by init before a user logs in?

There are no "hard" limits to RLIMIT_NPROC. However, on fork, childern
inherits the parents limits. Non-root users can not raise the limit,
just lower it. So unless limits are set in the bootscripts, the defaults
set in kernel/fork.c will be used on services.

--
Natanael Copa


