Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUJGGQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUJGGQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUJGGQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 02:16:27 -0400
Received: from holomorphy.com ([207.189.100.168]:30412 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267287AbUJGGQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 02:16:26 -0400
Date: Wed, 6 Oct 2004 23:16:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: __init poisoning for i386, too
Message-ID: <20041007061610.GU9106@holomorphy.com>
References: <20041006221854.GA1622@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006221854.GA1622@elf.ucw.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 12:18:55AM +0200, Pavel Machek wrote:
> Overwrite __init section so calls to __init functions from normal code
> are catched, reliably. I wonder if this should be configurable... but
> it is configurable on x86-64 so I copied it. Please apply,

Any chance we could:
(a) set the stuff to 0x0f0b so illegal instructions come of it; jumps are
	most often aligned to something > 16 bits anyway
(b) poison __initdata, memsetting to some bit pattern oopsable to dereference


-- wli
