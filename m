Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268186AbUIPSJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268186AbUIPSJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUIPSJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:09:58 -0400
Received: from sd291.sivit.org ([194.146.225.122]:26033 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268504AbUIPSI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:08:28 -0400
Date: Thu, 16 Sep 2004 20:09:09 +0200
From: Stelian Pop <stelian@popies.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040916180908.GB9886@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org> <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org> <20040916104535.GA3146@crusoe.alcove-fr> <20040916100050.17a9b341.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916100050.17a9b341.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 10:00:50AM -0700, Andrew Morton wrote:

> Stelian Pop <stelian@popies.net> wrote:
> >
> > Here is the updated patch.
> 
> Looks good to me.
> 
> You're using `head' as "the place from which `get' gets characters" and
> you're using `tail' as "the place where `put' puts characters".  So the
> FIFO is, logically:
> 
> 
>           tail            head
>     * ->  ********************   -> *
>      put                         get
> 

That was the intent, yes.

> I've always done it the other way: you put stuff onto the head and take
> stuff off the tail.  Now I have a horid feeling that I've always been
> arse-about.  hrm.  

Maybe I should use 'start' and 'end' as indices after all, they
are less subject to confusion.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
