Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUCKStK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUCKStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:49:10 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:51152 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261664AbUCKStF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:49:05 -0500
Date: Thu, 11 Mar 2004 18:48:35 +0000
From: Dave Jones <davej@redhat.com>
To: pg smith <pete@linuxbox.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LKM rootkits in 2.6.x
Message-ID: <20040311184835.GA21330@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	pg smith <pete@linuxbox.co.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 11:26:23AM -0800, pg smith wrote:
 > Any thoughts on the future of LKM rootkits in the 2.6 kernel branch ? In
 > the last few years I've become quite interested in them (from a defensive
 > point of view), but with the 2.6 kernel no longer exporting the syscall
 > table, intercepting system calls would appear to be a non-starter now.

Don't bet on it.  They'll just start doing what binary-only driver vendors
have been doing for months.. If the table isn't exported, they find a symbol
that is exported, and grovel around in memory near there until they find
something that looks like it, and patch accordingly.

		Dave

