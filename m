Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbUBZU2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbUBZU2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:28:11 -0500
Received: from ns.suse.de ([195.135.220.2]:59034 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262964AbUBZURE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:17:04 -0500
To: Timothy Miller <miller@techsource.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD64
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
	<403E4681.20603@techsource.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Feb 2004 21:17:00 +0100
In-Reply-To: <403E4681.20603@techsource.com.suse.lists.linux.kernel>
Message-ID: <p731xoh61fn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:
> 
> If these sorts of branches are common enough (and I suspect they are),

No they are not at all. Did you really read the descriptions of
their semantics in this thread from Richard or Jun? They are
completely useless for a 64bit program because they will truncate your
64bit program counter to 16bits. 

They may make sense in 16bit compat mode with 64K segment, but there
there is no incompatibility because this difference only applies to
64bit programs. I doubt anybody has ever used them in a 64bit or even
in a 32bit program.

> Why did Intel decide to do that?

Most likely they didn't plan to, but it happened by accident 
and is obscure enough to be not worth fixing. I would agree with
them that it's not worth fixing.

-Andi
