Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263862AbUEMHQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbUEMHQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbUEMHQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:16:28 -0400
Received: from holomorphy.com ([207.189.100.168]:38588 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263862AbUEMHO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:14:56 -0400
Date: Thu, 13 May 2004 00:13:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Adam Litke <agl@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513071359.GU1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
References: <20040513055520.GF27403@zax> <20040513060549.GA12695@mulix.org> <20040513065912.GR1397@holomorphy.com> <1084432141.13731.99.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084432141.13731.99.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 16:59, William Lee Irwin III wrote:
>> Atop my other patch to nuke the unused global variables, here is a patch
>> to manually inline __do_mmap_pgoff(), removing the inline usage. Untested.
>> Are you sure you want this? #ifdef'ing out the hugetlb case is somewhat
>> more digestible with the inline in place, e.g.:

On Thu, May 13, 2004 at 05:09:01PM +1000, Benjamin Herrenschmidt wrote:
> Well, I did the breakup in 2 pieces in the first place for 2 reasons:
>  - the original patch had some subtle issues with accounting
>  - do_mmap_pgoff is already such a mess, let's not make it worse
> I mean, it's awful to get anything right in this function, especially
> the cleanup/exit path, which is why I think it's more maintainable
> cut in 2.

Well, writing it vaguely convinced me that it wasn't a great idea; I
suppose now that Muli can look at the result he'll be convinced likewise.


-- wli
