Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVACKHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVACKHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 05:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVACKHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 05:07:48 -0500
Received: from [213.146.154.40] ([213.146.154.40]:37349 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261415AbVACKHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 05:07:32 -0500
Date: Mon, 3 Jan 2005 10:07:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050103100725.GA17856@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> add-page-becoming-writable-notification.patch
>   Add page becoming writable notification

David, this still has the bogus address_space operation in addition to
the vm_operation.  page_mkwrite only fits into the vm_operations scheme,
so please remove the address_space op.  Also the code will be smaller
and faster witout that indirection..

