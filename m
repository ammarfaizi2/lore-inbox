Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVBOW6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVBOW6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVBOW5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:57:32 -0500
Received: from colin2.muc.de ([193.149.48.15]:32014 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261930AbVBOWz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:55:28 -0500
Date: 15 Feb 2005 23:55:27 +0100
Date: Tue, 15 Feb 2005 23:55:27 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 kernel support MAX memory.
Message-ID: <20050215225527.GB87835@muc.de>
References: <3174569B9743D511922F00A0C94314230808586B@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230808586B@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 02:57:14PM -0800, YhLu wrote:
> It passed the memtest86+ 3.1a

Are you sure it even tests the full 128GB? Traditionally PAE only
supports 64GB. 

> 
> No oops dump, it just restart the system.

At what point exactly? You probably have a serial
console. What are the last lines.

That could well be an ECC error. You can see if mcelog
logs something after reboot (kernel should preserve 
machine check events) 

Or you could switch around the DIMMs of the CPUs for 
testing.

-Andi
