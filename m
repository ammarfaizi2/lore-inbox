Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVD0SEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVD0SEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVD0SEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:04:08 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:23006 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261892AbVD0SDx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:03:53 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: returning non-ram via ->nopage, was Re: [patch] mspec driver for 2.6.12-rc2-mm3
References: <16987.39773.267117.925489@jaguar.mkp.net>
	<20050412032747.51c0c514.akpm@osdl.org>
	<yq07jj8123j.fsf@jaguar.mkp.net>
	<20050413204335.GA17012@infradead.org>
	<yq08y3bys4e.fsf@jaguar.mkp.net>
	<20050424101615.GA22393@infradead.org>
	<yq03btftb9u.fsf@jaguar.mkp.net>
	<20050425144749.GA10093@infradead.org>
	<yq0ll75rxsl.fsf@jaguar.mkp.net> <426FB56B.5000006@pobox.com>
	<20050427155526.GA25921@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 27 Apr 2005 14:03:50 -0400
In-Reply-To: <20050427155526.GA25921@infradead.org>
Message-ID: <yq0hdhsrta1.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Wed, Apr 27, 2005 at 11:53:15AM -0400, Jeff Garzik
Christoph> wrote:
>> I don't see anything wrong with a ->nopage approach.
>> 
>> At Linus's suggestion, I used ->nopage in the implementation of
>> sound/oss/via82cxxx_audio.c.

Christoph> The difference is that you return kernel memory (actually
Christoph> pci_alloc_consistant memory that has it's own set of
Christoph> problems), while this is memory not in mem_map, so he
Christoph> allocates some regularly kernel memory too to have a struct
Christoph> page and just leaks it

Are you suggesting then that we change do_no_page to handle this as a
special return value then?

Jes
