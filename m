Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWADAdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWADAdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWADAdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:33:15 -0500
Received: from cantor.suse.de ([195.135.220.2]:31921 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965069AbWADAdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:33:14 -0500
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets on the stack
Date: Wed, 4 Jan 2006 01:33:44 +0100
User-Agent: KMail/1.8
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200601032158.14057.ak@suse.de> <200601040028.40633.arnd@arndb.de>
In-Reply-To: <200601040028.40633.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601040133.44137.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 01:28, Arnd Bergmann wrote:

> Hmm, can you include the same change for compat_sys_select()?
> When that was introduced, sys_select and compat_sys_select were
> basically identical in their code, which makes it a lot easier
> to verify that the compat_ version is correct.

Ah good point. I forgot about those. Will fix them up for the next version
of the patch.

> Interestingly, doing a diff between sys_select and compat_sys_select
> in the current kernel seems to suggest that they are both buggy
> in that they miss checks for failing __put_user, but in /different/
> places.

Ok will do a sync first.

-Andi
