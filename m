Return-Path: <linux-kernel-owner+w=401wt.eu-S1751597AbWLMOGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWLMOGS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWLMOGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:06:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44298 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751597AbWLMOGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:06:18 -0500
Date: Wed, 13 Dec 2006 07:20:48 -0600
From: Robin Holt <holt@sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: VM_RESERVED vs vm_normal_page()
Message-ID: <20061213132048.GB30950@lnx-holt.americas.sgi.com>
References: <1165984677.11914.159.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165984677.11914.159.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 03:37:57PM +1100, Benjamin Herrenschmidt wrote:
> Hi folks !
> 
> What is the logic regarding VM_RESERVED, and more specifically, why is
> vm_normal_page() nor returning NULL for these ?

Near as I could ever tell from the discussion on linux-mm, it is a page
which should not be dumped.  If you have a normal page in a mapping
which you don't want swapped out, the only way I could ever figure to
prevent that from happening is by doing an extra get_user_page() on it
to add a reference.

Thanks,
Robin
