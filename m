Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTFOW5P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 18:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTFOW5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 18:57:15 -0400
Received: from are.twiddle.net ([64.81.246.98]:31126 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262984AbTFOW5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 18:57:14 -0400
Date: Sun, 15 Jun 2003 16:11:06 -0700
From: Richard Henderson <rth@twiddle.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: force_successful_syscall_return() buggy?
Message-ID: <20030615231106.GA14939@twiddle.net>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030615193604.L5417@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030615193604.L5417@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 07:36:04PM +0100, Russell King wrote:
> AFAIK, sys_execve() does not ensure that the kernel stack will be empty
> before starting the user space thread, so these programs are running with
> a slightly reduced kernel stack.

Indeed.  This is fixed in a rewrite I have of entry.S, but
that's not particularly stable at the moment...


r~
