Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWAQI3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWAQI3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWAQI3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:29:18 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:26401 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932328AbWAQI3R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:29:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJJfcUyBW6bqfK6mk0fmcLO4E4Bjqv6DpIy5Wm6i335hD1JSx6SWbikHSCVKcoh0X1Pu86OVnxzBKRdC4e+PoqYYuHnBen/KdIitfNaT6QAjh6uacgwZRxYsJwEGncV1vFOb6wywtr8HNAZCOqtx2Dbc+Vw/TUZMky93L5eVIw4=
Message-ID: <aec7e5c30601170029if0ed895le2c18b26eb7c6a42@mail.gmail.com>
Date: Tue, 17 Jan 2006 17:29:15 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: Race in new page migration code?
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.62.0601152251550.17034@schroedinger.engr.sgi.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> On Sun, 15 Jan 2006, Nick Piggin wrote:
>
> > OK (either way is fine), but you should still drop the __isolate_lru_page
> > nonsense and revert it like my patch does.
>
> Ok with me. Magnus: You needed the __isolate_lru_page for some other
> purpose. Is that still the case?

It made sense to have it broken out when it was used twice within
vmscan.c, but now when the patch changed a lot and the function is
used only once I guess the best thing is to inline it as Nick
suggested. I will re-add it myself later on when I need it. Thanks.

/ magnus
