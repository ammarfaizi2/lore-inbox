Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWEDG16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWEDG16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 02:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWEDG16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 02:27:58 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:5768 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751414AbWEDG16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 02:27:58 -0400
Date: Thu, 4 May 2006 02:22:48 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-rc2-mm1
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jan Beulich <jbeulich@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@google.com>
Message-ID: <200605040224_MC3-1-BEC3-2856@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <445903DD.6090408@shadowen.org>

On Wed, 03 May 2006 20:26:21 +0100, Andy Whitcroft wrote:

>        <ffffffff8047c8e8>{__sched_text_start+1856} <EOE>new stack 0 (0 0
> 10046 10 ffffffff8047c8e8)

Wow.  The extra debug patch yields... exactly the same address that's
already being printed.

The real problem is that the stack-dump code prints the wrong symbol
name here.  I don't see any easy way to fix it other than to put some
filler at __sched_text_start so the first sched function has a unique
address.


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

