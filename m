Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUIGSFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUIGSFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIGSFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:05:48 -0400
Received: from verein.lst.de ([213.95.11.210]:55709 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268234AbUIGSFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:05:44 -0400
Date: Tue, 7 Sep 2004 20:05:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove wake_up_all_sync
Message-ID: <20040907180538.GA12434@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040907151154.GB9577@lst.de> <1094576397.9607.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094576397.9607.0.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:59:58PM +0100, Alan Cox wrote:
> On Maw, 2004-09-07 at 16:11, Christoph Hellwig wrote:
> > no user in sight
> 
> That doesn't mean its not a logical part of the API, and since its a
> define one which has zero cost in being present. I think you are taking
> things beyond the ridiculous in this area.

The sync wakeups are an absolutely special case, we're only using them
in the pipe code on __wake_up_parent.  If you think it's a logical part
of the API were would you want to use it for?

