Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVCIFme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVCIFme (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVCIFmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:42:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38376 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261351AbVCIFm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:42:28 -0500
Date: Wed, 9 Mar 2005 00:42:28 -0500
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops tracing and /proc
Message-ID: <20050309054228.GB2531@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1110346587.7123.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110346587.7123.14.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 12:36:27AM -0500, Lee Revell wrote:
 > I am trying to decode an Oops per the instructions in
 > Documentation/oops-tracing.txt.  The instructions say to run it through
 > ksymoops with the "-k /proc/ksyms" argument.
 > 
 > But, I do not have this file!  The closest thing I have
 > is /proc/kallsyms.  ksymoops complains that it does not understand the
 > syntax of this file.
 > 
 > What am I doing wrong?

If you have CONFIG_KALLSYMS enabled, you don't need ksymoops
as the backtrace gets decoded to symbol names for you.

The only use for ksymoops in a 2.6 kernel is probably the
disassembly of the Code: line.
http://www.kernel.org/pub/linux/utils/kernel/ksymoops/

		Dave

