Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265328AbUFBCoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUFBCoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 22:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUFBCoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 22:44:14 -0400
Received: from holomorphy.com ([207.189.100.168]:19604 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265328AbUFBCoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 22:44:12 -0400
Date: Tue, 1 Jun 2004 19:43:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: Hugepage bugfix
Message-ID: <20040602024358.GX2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, apw@shadowen.org,
	linux-kernel@vger.kernel.org
References: <20040602022312.GB2042@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602022312.GB2042@zax>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 12:23:12PM +1000, David Gibson wrote:
> Currently the hugepage code stores the hugepage destructor in the
> mapping field of the second of the compound pages.  However, this
> field is never cleared again, which causes tracebacks from
> free_pages_check() if the hugepage is later destroyed by reducing the
> number in /proc/sys/vm/nr_hugepages.  This patch fixes the bug by
> clearing the mapping field when the hugepage is freed.

Good catch; thanks.


-- wli
