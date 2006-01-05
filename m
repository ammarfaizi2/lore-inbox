Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752067AbWAEGln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbWAEGln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWAEGln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:41:43 -0500
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:52170 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1752067AbWAEGln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:41:43 -0500
Date: Thu, 5 Jan 2006 01:38:32 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.15] i386: Optimize local APIC timer interrupt
  code
To: Willy Tarreau <willy@w.ods.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601050141_MC3-1-B553-82B6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060105060314.GB7142@w.ods.org>

On Thu, 5 Jan 2006 at 07:03:14 +0100, Willy Tarreau wrote:

> +     if (likely(--per_cpu(prof_counter, cpu)) <= 0) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
are you sure about this ? it looks suspicious to me. I would have
expected something like  this instead :

+       if (likely(--per_cpu(prof_counter, cpu) <= 0)) {


  Nice catch, proving yet again the value of posting code for review!


-- 
Chuck
Currently reading: _Thud!_ by Terry Pratchett
