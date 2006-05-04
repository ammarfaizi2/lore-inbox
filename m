Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWEDMNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWEDMNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 08:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWEDMNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 08:13:42 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:51138 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP
	id S1750951AbWEDMNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 08:13:41 -0400
X-ORBL: [69.149.117.205]
Date: Thu, 4 May 2006 07:08:33 -0500
From: Michael Halcrow <lkml@halcrow.us>
To: Pavel Machek <pavel@ucw.cz>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/12: eCryptfs] eCryptfs version 0.1.6
Message-ID: <20060504120833.GA9194@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20060504031755.GA28257@hellewell.homeip.net> <20060504072849.GC5359@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504072849.GC5359@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 07:28:49AM +0000, Pavel Machek wrote:
> > processing the 4096-byte extents. The second modification is that
> > the header region occupies either 8192 bytes or the page size of
> > the host on which the file is created, whichever is larger. This
> > maximizes the probability that pages will be aligned between the
> > unencrypted and encrypted data, which is not a requirement, but it
> > helps with performance.
> 
> Does that mean that 10-bytes file now occupies 12KB disk space in
> common case of 4K filesystem?

Yes.

Mike
