Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTKVLFH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 06:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTKVLFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 06:05:07 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:14862 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262181AbTKVLFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 06:05:00 -0500
Date: Sat, 22 Nov 2003 11:04:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Juergen Hasch <lkml@elbonia.de>
Cc: Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
Subject: Re: Using get_cwd inside a module.
Message-ID: <20031122110459.A31359@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Juergen Hasch <lkml@elbonia.de>,
	Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
References: <3FBEA83B.1060001@bangstate.com> <200311221033.35108.lkml@elbonia.de> <20031122101559.A30932@infradead.org> <200311221145.39585.lkml@elbonia.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200311221145.39585.lkml@elbonia.de>; from lkml@elbonia.de on Sat, Nov 22, 2003 at 11:45:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 11:45:39AM +0100, Juergen Hasch wrote:
> > What are the exact requirements of changedfiles or samba?
> 
> Samba needs to be able to notify a client machine, when a file in a 
> directory changes (i.e. is added/removed/modified/renamed). The directory 
> to be watched is given by the client and can include subdirectories.

Well, reporting a single path component relative to the parent directory
is doable, there's just no way to have a canonical absolute or
multi-component pathname.

