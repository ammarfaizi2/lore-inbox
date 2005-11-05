Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVKESmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVKESmY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVKESmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:42:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47786 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932194AbVKESmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:42:23 -0500
Date: Sat, 5 Nov 2005 18:42:22 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jon Masters <jonathan@jonmasters.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Message-ID: <20051105184222.GN7992@ftp.linux.org.uk>
References: <20051105182728.GB27767@apogee.jonmasters.org> <20051105103358.2e61687f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105103358.2e61687f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 10:33:58AM -0800, Andrew Morton wrote:
> Jon Masters <jonathan@jonmasters.org> wrote:
> >
> > [PATCH]: This modifies the gendisk and hd_struct structs to replace "policy"
> >  with "readonly" (as that's the only use for this field).

... for now.  IOW, NAK on that part - it's *not* a boolean and it's
intended to be used for e.g control of caching behaviour.  Stuff
like "mark it r/o for now without losing information about hw situation"
also should go there.
