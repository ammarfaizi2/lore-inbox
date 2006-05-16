Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWEPQee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWEPQee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWEPQee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:34:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:27575 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932110AbWEPQee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:34:34 -0400
Date: Tue, 16 May 2006 17:34:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: James Morris <jmorris@namei.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: endian fix
Message-ID: <20060516163426.GF27946@ftp.linux.org.uk>
References: <20060516152305.GI10143@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0605161149540.16379@d.namei> <jeiro6sztd.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeiro6sztd.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 06:24:14PM +0200, Andreas Schwab wrote:
> James Morris <jmorris@namei.org> writes:
> 
> > On Tue, 16 May 2006, Alexey Dobriyan wrote:
> >
> >> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >
> > Hmm, I'm certain this was tested (perhaps on a BE machine, though).
> 
> ntohs and htons are identical operations.  Either you swap or you don't,
> but there is only one way to swap a short.

Indeed, but that kind of crap still deserves a fix - same result, but
use that kind of misuse is begging for bugs later on.
