Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVJZPBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVJZPBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 11:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVJZPBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 11:01:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:61896 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964775AbVJZPBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 11:01:03 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: DIE_GPF vs. DIE_PAGE_FAULT/DIE_TRAP
Date: Wed, 26 Oct 2005 17:01:52 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <435FB26B.76F0.0078.0@novell.com>
In-Reply-To: <435FB26B.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261701.52611.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 16:44, Jan Beulich wrote:
> What is the reason for notify_die(DIE_GPF, ...) to be run late in the GP
> fault handler (on both i386 and x86-64), while for other exceptions it
> gets run first thing (as I would have expected for all exceptions)?

"die"s as the name says are normally only supposed to run when the
error is determined to be an illegal kernel fault.  Page fault
got an exception to that to make kprobes work. For the others
it is mostly only because there is no good way to check
for illegal kernel faults first.

-Andi
