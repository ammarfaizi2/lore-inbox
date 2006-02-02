Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWBBNbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWBBNbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWBBNbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:31:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:14006 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751061AbWBBNbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:31:49 -0500
From: Andi Kleen <ak@suse.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH] Dynamically allocated pageflags
Date: Thu, 2 Feb 2006 14:31:29 +0100
User-Agent: KMail/1.8.2
Cc: "linux-mm" <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <200602022111.32930.ncunningham@cyclades.com>
In-Reply-To: <200602022111.32930.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602021431.30194.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 12:11, Nigel Cunningham wrote:
> Hi everyone.
> 
> This is my latest revision of the dynamically allocated pageflags patch.
> 
> The patch is useful for kernel space applications that sometimes need to flag
> pages for some purpose, but don't otherwise need the retain the state. A prime
> example is suspend-to-disk, which needs to flag pages as unsaveable, allocated
> by suspend-to-disk and the like while it is working, but doesn't need to
> retain any of this state between cycles.

It looks like total overkill for a simple problem to me. And is there really
any other user of this other than swsusp?

-Andi

