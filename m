Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUFVSeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUFVSeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUFVSeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:34:16 -0400
Received: from [213.146.154.40] ([213.146.154.40]:9866 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265147AbUFVSbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:31:16 -0400
Date: Tue, 22 Jun 2004 19:31:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] consolidate in kernel configuration
Message-ID: <20040622183115.GA7345@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <200406221557.i5MFv3YN020056@voidhawk.shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406221557.i5MFv3YN020056@voidhawk.shadowen.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 04:57:03PM +0100, Andy Whitcroft wrote:
> It appears that when we enable CONFIG_IKCONFIG and
> CONFIG_IKCONFIG_PROC that we actually include two different copies of
> the .config file.  One plain text and one compressed.  The plain
> text one used when extracting from the binary is also not recovered
> cleanly.  The patch below removes this duplication using the same
> compressed version for both purposes.  Hopefully this will also
> make it more reasonable to default this option to on.

Should we really compress it inside the kernel image?  If you care
for space you compress the kernel image anyway.

