Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUHBG7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUHBG7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUHBG7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:59:37 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:42640 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S266308AbUHBGry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:47:54 -0400
Subject: Re: [RFC] [PATCH 2/2] export module parameters in sysfs for
	modules _and_ built-in code: remove /sys/module/*parameters*
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040801165410.GB8667@dominikbrodowski.de>
References: <20040801165410.GB8667@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1091429252.426.15.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 16:47:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 02:54, Dominik Brodowski wrote:
> Remove the exporting of module parameters in sysfs in /sys/module,
> and clean up the exporting of the attribute "refcnt". One functionality
> change: it is always exported now, and if !CONFIG_MODULE_UNLOAD, it reports
> 1.

I don't think this is a good idea: we shouldn't lie to userspace unless
we need to for compatibility reasons.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

