Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWI1HQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWI1HQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbWI1HQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:16:19 -0400
Received: from colin.muc.de ([193.149.48.1]:36624 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751655AbWI1HQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:16:19 -0400
Date: 28 Sep 2006 09:16:17 +0200
Date: Thu, 28 Sep 2006 09:16:17 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
Message-ID: <20060928071617.GA84041@muc.de>
References: <451B64E3.9020900@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451B64E3.9020900@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 11:00:03PM -0700, Jeremy Fitzhardinge wrote:
> When CONFIG_DEBUG_BUGVERBOSE is enabled, the embedded file and line
> information makes a disassembler very unhappy, because it tries to
> parse them as instructions (it probably makes the CPU's instruction
> decoder a little unhappy too).
> 
> This patch moves them out of line, and calls the ud2 from the code -
> the call makes sure the original %eip is available on the top of the
> stack.  The result is a happy disassembler, with no loss of debugging
> information.

x86-64 has a much better solution for this. Please copy that one.

-Andi
