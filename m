Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVKKTh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVKKTh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVKKThz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:37:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26053 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750953AbVKKThz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:37:55 -0500
Date: Fri, 11 Nov 2005 19:37:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 2/12] relayfs: export relayfs_create_file() with fileops param
Message-ID: <20051111193749.GA17018@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, karim@opersys.com
References: <17268.51814.215178.281986@tut.ibm.com> <17268.51975.485344.880078@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17268.51975.485344.880078@tut.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 10:47:03AM -0600, Tom Zanussi wrote:
> This patch adds a mandatory fileops param to relayfs_create_file() and
> exports that function so that clients can use it to create files
> defined by their own set of file operations, in relayfs.  The purpose
> is to allow relayfs applications to create their own set of 'control'
> files alongside their relay files in relayfs rather than having to
> create them in /proc or debugfs for instance.  relayfs_create_file()
> is also used by relay_open_buf() to create the relay files for a
> channel.  In this case, a pointer to relayfs_file_operations is passed
> in, along with a pointer to the buffer associated with the file.

Again, NACK,  control files don't belong into relayfs.

