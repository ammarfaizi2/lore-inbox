Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWBOUaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWBOUaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWBOUaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:30:09 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:35737 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932457AbWBOUaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:30:07 -0500
Date: Wed, 15 Feb 2006 15:31:03 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "Charles P. Wright" <cwright@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace and threads
Message-ID: <20060215203103.GA7634@ccure.user-mode-linux.org>
References: <1140030841.10553.9.camel@polarbear.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140030841.10553.9.camel@polarbear.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:14:01PM -0500, Charles P. Wright wrote:
> I tried using
> ptrace(PTRACE_DETACH, ..., ..., SIGSTOP) in the original tracing process
> to stop the process after the fork, followed by a ptrace(PTRACE_ATTACH)
> in the new tracing process.

This has worked for me in the past.  The one tricky bit is that the process
needs a SIGCONT before it will run again (and appear to be active under
the new tracer).

				Jeff
