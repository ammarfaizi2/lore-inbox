Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272686AbTHKP7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272741AbTHKP7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:59:15 -0400
Received: from holomorphy.com ([66.224.33.161]:44712 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272686AbTHKP5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:57:47 -0400
Date: Mon, 11 Aug 2003 08:58:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rob Landley <rob@landley.net>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
Subject: Re: [PATCH] O13int for interactivity
Message-ID: <20030811155848.GE32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rob Landley <rob@landley.net>, Con Kolivas <kernel@kolivas.org>,
	Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au,
	linux-kernel@vger.kernel.org, mingo@elte.hu,
	felipe_alfaro@linuxmail.org
References: <200308050207.18096.kernel@kolivas.org> <20030804230337.703de772.akpm@osdl.org> <200308051726.14501.kernel@kolivas.org> <200308110257.25601.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308110257.25601.rob@landley.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 02:57:25AM -0400, Rob Landley wrote:
> It seems that there's a special case, where a task that was blocked on a read 
> (either from a file or from swap) wants to be scheduled immediately, but with 
> a really short timeslice.  I.E. give it the ability to submit another read 
> and block on it immediately, but if a single jiffy goes by and it hasn't done 
> it, it should go away.
> This has nothing to do with the normal priority levels or being considered 
> interactive or not.  As I said, a special case.  IO_UNBLOCKED_FLAG or some 
> such.  Maybe unnecessary...
> (Once again, the percentage of CPU time to devote to a task and the immediacy 
> of scheduling that task are in opposition.  The "priority" abstraction is a 
> bit too simple at times...)

This is bandwidth vs. latency. Priority isn't directly correlated to
either. There are patches floating around for more explicit cpu
bandwidth control (which IMHO would be ideal for the xmms problem).
Differentiated service with respect to latency is a bit of a different
story, and appears to have more complex semantics (!= complex code!)
than bandwidth.


-- wli
