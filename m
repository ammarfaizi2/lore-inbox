Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVAFNxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVAFNxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVAFNxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:53:11 -0500
Received: from one.firstfloor.org ([213.235.205.2]:62650 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262824AbVAFNwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:52:41 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V3 [2/4]: Extension of clear_page to take an order
 parameter
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	<41C20E3E.3070209@yahoo.com.au>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
	<Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
	<Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041513330.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501051524020.9911@schroedinger.engr.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 06 Jan 2005 14:52:36 +0100
In-Reply-To: <Pine.LNX.4.58.0501051524020.9911@schroedinger.engr.sgi.com> (Christoph
 Lameter's message of "Wed, 5 Jan 2005 15:25:20 -0800 (PST)")
Message-ID: <m1652awtp7.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:

> Here is an updated version that is independent of the first patch and
> contains all the necessary modifications to make clear_page take a second
> parameter.

I still think the clear_page order addition is completely pointless,
because for > order 0 you probably want a cache bypassing store
in a separate function.

Removing it would also make the patch much less intrusive.

-Andi
