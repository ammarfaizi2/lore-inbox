Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVLMJDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVLMJDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVLMJDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:03:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50568 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964814AbVLMJDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:03:47 -0500
Date: Tue, 13 Dec 2005 09:03:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213090331.GB27857@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org,
	arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213004257.0f87d814.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 12:42:57AM -0800, Andrew Morton wrote:
> scsi/sd.c is currently getting an ICE.  None of the new SAS code compiles,
> due to extensive use of anonymous unions.

This is just the headers in the luben code which need redoing completely
because they're doing other stupid things like using bitfields for on the
wire structures.

