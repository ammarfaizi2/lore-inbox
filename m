Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWCOT5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWCOT5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 14:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWCOT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 14:57:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19144 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750792AbWCOT5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 14:57:49 -0500
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
	"struct resource"
From: Arjan van de Ven <arjan@infradead.org>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
In-Reply-To: <20060315193114.GA7465@in.ibm.com>
References: <20060315193114.GA7465@in.ibm.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 20:57:45 +0100
Message-Id: <1142452665.3021.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One of the possible solutions to this problem is that expand the size
> of "start" and "end" to "unsigned long long". But whole of the PCI and
> driver code has been written assuming start and end to be unsigned long
> and compiler starts throwing warnings. 


please use dma_addr_t then instead of unsigned long long

this is the right size on all platforms afaik (could a ppc64 person
verify this?> ;)

