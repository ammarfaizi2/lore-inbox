Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVDEJyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVDEJyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVDEJv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:51:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2015 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261684AbVDEJqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:46:07 -0400
Date: Tue, 5 Apr 2005 10:45:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405094535.GA29095@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mackerras <paulus@samba.org>, Dave Airlie <airlied@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org> <20050405074405.GE26208@infradead.org> <21d7e99705040502073dfa5e5@mail.gmail.com> <16978.22617.338768.775203@cargo.ozlabs.ibm.com> <20050405093020.GA28620@infradead.org> <16978.24070.786761.641930@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16978.24070.786761.641930@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 07:44:38PM +1000, Paul Mackerras wrote:
> Christoph Hellwig writes:
> 
> >  - the magic CONFIG_COMPAT changes for SHM handles should only be done when
> >    a module is set.  CONFIG_COMPAT is set for mostly 64bit systems that can
> >    run 32bit code and drm shouldn't behave differently just because we can
> >    run 32bit code.
> 
> Yes it should - we can have a 64-bit X server and a 32-bit DRI
> client.  In this case the server will allocate a _DRM_SHM area and
> pass the handle to the client, which will then try to mmap the area.
> If we give a 64-bit handle to the server the client won't be able to
> access the area.

Please make it a module option so it doesn't regress everyone for your
specific needs.

