Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWGRQkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWGRQkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWGRQkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:40:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26524 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751364AbWGRQkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:40:45 -0400
Date: Tue, 18 Jul 2006 12:40:23 -0400
From: Dave Jones <davej@redhat.com>
To: Thomas Dillig <tdillig@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Null dereference errors in the kernel
Message-ID: <20060718164023.GA29417@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas Dillig <tdillig@stanford.edu>, linux-kernel@vger.kernel.org
References: <44BC5A3F.2080005@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BC5A3F.2080005@stanford.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 08:49:19PM -0700, Thomas Dillig wrote:

 > 144 drivers/char/agp/ati-agp.c
 > NULL dereference of variable "ati_generic_private.gatt_pages" in 
 > function call (drivers/char/agp/ati-agp.c:ati_free_gatt_pages).
 
I think this is a false positive.
It's a freeing function, the other half of ati_create_gatt_pages,
which always gets called beforehand, and if that fails, we should
never get to ati_free_gatt_pages.

		Dave

-- 
http://www.codemonkey.org.uk
