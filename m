Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWAGEDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWAGEDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 23:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbWAGEDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 23:03:25 -0500
Received: from ns2.suse.de ([195.135.220.15]:59818 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932279AbWAGEDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 23:03:24 -0500
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] use local_t for page statistics
Date: Sat, 7 Jan 2006 05:03:13 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20060106215332.GH8979@kvack.org> <200601070425.24810.ak@suse.de> <43BF3A06.10502@yahoo.com.au>
In-Reply-To: <43BF3A06.10502@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070503.14336.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 04:48, Nick Piggin wrote:

> 
> At a 3x cache footprint cost? (and probably more than 3x for icache, though
> I haven't checked) And I think hardware trends are against us. (Also, does
> it have race issues with nested interrupts that Andrew noticed?)

Well the alternative would be to just let them turn off interrupts.
If that's cheap for them that's fine too. And would be equivalent
to what the current high level code does.

If you worry about icache footprint it can be even done out of line.

-Andi
