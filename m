Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbULAQgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbULAQgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbULAQgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:36:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41390 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261303AbULAQgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:36:21 -0500
Date: Wed, 1 Dec 2004 11:36:02 -0500
From: Dave Jones <davej@redhat.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i915 driver - bad reference counting
Message-ID: <20041201163602.GA5736@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lukas Hejtmanek <xhejtman@mail.muni.cz>,
	linux-kernel@vger.kernel.org
References: <20041201151418.GA17357@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201151418.GA17357@mail.muni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 04:14:18PM +0100, Lukas Hejtmanek wrote:
 > Hello,
 > 
 > I start Xserver using i915 driver and then I shut it down, I've noticed that
 > reference count is still 1 (not 0 as expected). Why? I have kernel 2.6.10-rc1.
 > (Could it be used by agpgart? I do not have agpgart as a module)

No, because dri uses agpgart, not the other way around.

(Though agpgart's module refcounting is headshot, and has needed fixing
 for quite a while.)

		Dave

