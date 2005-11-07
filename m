Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVKGDnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVKGDnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKGDnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:43:14 -0500
Received: from outbound04.telus.net ([199.185.220.223]:25340 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S932387AbVKGDnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:43:12 -0500
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH]: Clean up of __alloc_pages
Date: Mon, 7 Nov 2005 04:42:58 +0100
User-Agent: KMail/1.8
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <20051028183326.A28611@unix-os.sc.intel.com> <20051106124944.0b2ccca1.pj@sgi.com> <436EC2AF.4020202@yahoo.com.au>
In-Reply-To: <436EC2AF.4020202@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511070442.58876.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 November 2005 03:57, Nick Piggin wrote:

>
> I don't think so because if the cpuset can be freed, then its page
> might be unmapped from the kernel address space if use-after-free
> debugging is turned on. And this is a use after free :)

RCU could be used to avoid that. Just only free it in a RCU callback.

-Andi
