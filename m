Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVAYO2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVAYO2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVAYO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:28:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26012 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261950AbVAYO2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:28:30 -0500
Date: Tue, 25 Jan 2005 14:27:57 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steve Lord <lord@xfs.org>
Cc: "Mukker, Atul" <Atulm@lsil.com>, "'Andi Kleen'" <ak@muc.de>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Mel Gorman'" <mel@csn.ul.ie>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Linux Memory Management List'" <linux-mm@kvack.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Grant Grundler'" <grundler@parisc-linux.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
Message-ID: <20050125142757.GA20442@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Lord <lord@xfs.org>, "Mukker, Atul" <Atulm@lsil.com>,
	'Andi Kleen' <ak@muc.de>,
	'Marcelo Tosatti' <marcelo.tosatti@cyclades.com>,
	'Mel Gorman' <mel@csn.ul.ie>,
	'William Lee Irwin III' <wli@holomorphy.com>,
	'Linux Memory Management List' <linux-mm@kvack.org>,
	'Linux Kernel' <linux-kernel@vger.kernel.org>,
	'Grant Grundler' <grundler@parisc-linux.org>
References: <0E3FA95632D6D047BA649F95DAB60E5705A70E61@exa-atlanta> <41F65514.3040707@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F65514.3040707@xfs.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is not the driver per se, but the way the memory which is the I/O
> source/target is presented to the driver. In linux there is a good
> chance it will have to use more scatter gather elements to represent
> the same amount of data.

Note that a change made a few month ago after seeing issues with
aacraid means it's much more likely to see contingous memory,
there were some numbers on linux-scsi and/or linux-kernel.

