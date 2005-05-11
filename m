Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVEKRvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVEKRvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVEKRvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:51:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43997 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262010AbVEKRuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:50:40 -0400
Date: Wed, 11 May 2005 18:50:50 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: cotte@freenet.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: add execute in place support
Message-ID: <20050511175050.GE10567@parcelfarce.linux.theplanet.co.uk>
References: <428216F7.30303@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428216F7.30303@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 04:30:15PM +0200, Carsten Otte wrote:
> +	BUG_ON(!mapping->a_ops->get_xip_page);

No need to put this assert here.  You'll get exactly as good a stack trace ...

> +		page = mapping->a_ops->get_xip_page(mapping,
> +			index*(PAGE_SIZE/512), 0);

... here, when you call through a null pointer.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
