Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWEKR34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWEKR34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWEKR34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:29:56 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:62080 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030390AbWEKR3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:29:55 -0400
Date: Thu, 11 May 2006 10:33:12 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.16
Message-ID: <20060511173312.GI25010@moss.sous-sol.org>
References: <20060511022547.GE25010@moss.sous-sol.org> <296295514.20060511123419@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296295514.20060511123419@dns.toxicfilms.tv>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Maciej Soltysiak (solt2@dns.toxicfilms.tv) wrote:
> But this one looks important, something that every kernel build
> has in its code path, however I am unable to say if I need it badly
> or maybe not.

The patch fixes a possible user-triggerable system lockup or memory leak.
In both cases it's a local DoS.

BTW, the CVE folks have decided to track this as two separate issues:

CVE-2006-1860 - the system lockup
CVE-2006-1859 - the memory leak

> Could we have a word or two under each patchlet that would qualify them
> somehow?
> Like:
> "Important, not required for all, apply if using SCTP"
> "Important, required for all, may *do bad things*, apply ASAP"
> "Critical, required for all, surely will *do bad things*, apply ASAP"

Assigning any official severity is a bit of a slippery slope, but
making sure it's clear what type of issue (i.e. local DoS in this case)
is very reasonable.

thanks,
-chris
