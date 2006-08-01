Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWHATbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWHATbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbWHATbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:31:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8424 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751841AbWHATbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:31:33 -0400
Date: Tue, 1 Aug 2006 15:31:29 -0400
From: Dave Jones <davej@redhat.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: use persistent allocation for cursor blinking.
Message-ID: <20060801193129.GV22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Roland Dreier <rdreier@cisco.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801185618.GS22240@redhat.com> <adairlc5ktk.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adairlc5ktk.fsf@cisco.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 12:15:35PM -0700, Roland Dreier wrote:
 >  > Every time the console cursor blinks, we do a kmalloc/kfree pair.
 >  > This patch turns that into a single allocation.
 > 
 > A naive question from someone who knows nothing about this subsystem:
 > is there any possibility of concurrent calls into this function, for
 > example if there are multiple cursors on a multiheaded system?

It's all called under the console_sem iirc.

		Dave

-- 
http://www.codemonkey.org.uk
