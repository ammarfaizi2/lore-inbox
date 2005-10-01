Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVJATpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVJATpX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVJATpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 15:45:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:17030 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750835AbVJATpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 15:45:23 -0400
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH][Fix] swsusp: Yet another attempt to fix Bug #4959
Date: Sat, 1 Oct 2005 21:45:29 +0200
User-Agent: KMail/1.8.2
Cc: "Discuss x86-64" <discuss@x86-64.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200510011813.54755.rjw@sisk.pl>
In-Reply-To: <200510011813.54755.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510012145.30067.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 October 2005 18:13, Rafael J. Wysocki wrote:

>
> This function allocates twice as much memory as needed for the direct
> mapping page tables and assigns the second half of it to the resume page
> tables.  This area is later marked with PG_nosave by swsusp, so that it is
> not overwritten during resume.
>
I prefered it when the additional page tables were allocated only on demand.

-Andi
