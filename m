Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWCGLWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWCGLWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbWCGLWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:22:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64457 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750790AbWCGLWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:22:13 -0500
Date: Tue, 7 Mar 2006 11:22:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
Message-ID: <20060307112206.GA29565@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060307021929.754329c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307021929.754329c9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 02:19:29AM -0800, Andrew Morton wrote:
> +ia64-dont-report-sn2-or-summit-hardware-as-an-error.patch
> +sgi-sn-drivers-dont-report-sn2-hardware-as-an-error.patch
> 
>  ia64 fixes

These are wrong.  The hardware is not available so -ENODEV is the right
return value.  Especially in the mmtimer case this is a real bug because
the module would stay loaded despite not beeing initialized and uneeded,
in the others it's just cosmetical but still wrong.

