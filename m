Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWAQJW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWAQJW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 04:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWAQJW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 04:22:58 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:22809 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932366AbWAQJW6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 04:22:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gEGq7nzj6nac+q7KL5hAuK1yupFlAFCBzrTTnnX6tvl5G6Tkjb0aEGwrSjQL+aVDcXcBSnK5Z9RmGdR8YGye2lazLSlZtP+bji6s7HgWgQbMlqJnp8A15t7bLquXrK7ZA8thZzjCApn5gfNRjD5uTz+DAxkN8TnaPKSX7XQRUPE=
Message-ID: <aec7e5c30601170122o7766fd4ep6285e3651be1a81e@mail.gmail.com>
Date: Tue, 17 Jan 2006 18:22:56 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Race in new page migration code?
Cc: Christoph Lameter <clameter@engr.sgi.com>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <43CCB262.9070304@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060114155517.GA30543@wotan.suse.de>
	 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
	 <20060114181949.GA27382@wotan.suse.de>
	 <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
	 <43C9DD98.5000506@yahoo.com.au>
	 <Pine.LNX.4.62.0601152251550.17034@schroedinger.engr.sgi.com>
	 <aec7e5c30601170029if0ed895le2c18b26eb7c6a42@mail.gmail.com>
	 <43CCB262.9070304@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Magnus Damm wrote:
> > On 1/16/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> >>On Sun, 15 Jan 2006, Nick Piggin wrote:
> >>
> >>
> >>>OK (either way is fine), but you should still drop the __isolate_lru_page
> >>>nonsense and revert it like my patch does.
> >>
> >>Ok with me. Magnus: You needed the __isolate_lru_page for some other
> >>purpose. Is that still the case?
> >
> >
> > It made sense to have it broken out when it was used twice within
> > vmscan.c, but now when the patch changed a lot and the function is
> > used only once I guess the best thing is to inline it as Nick
> > suggested. I will re-add it myself later on when I need it. Thanks.
> >
> > / magnus
> >
>
> I'm curious, what do you need it for?

I used that function when I worked on a memory resource control
prototype. This prototype has been superseeded by the pzone memory
resource controller posted on ckrm-tech recently.

/ magnus
