Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUHWUQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUHWUQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUHWUOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:14:30 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:36360 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267298AbUHWTGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:06:13 -0400
Date: Mon, 23 Aug 2004 20:06:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][6/7] add xattr support to tmpfs
Message-ID: <20040823200606.B20114@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
References: <Xine.LNX.4.44.0408231419010.13728-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Mon, Aug 23, 2004 at 02:20:58PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 02:20:58PM -0400, James Morris wrote:
> This patch adds xattr support to tmpfs, and a security xattr handler.
> Original patch from: Luke Kenneth Casson Leighton <lkcl@lkcl.net>

The generic xattr inode ops implementations should also move to xattr.c
(easy with my proposal of handing the sub-methods off the sb).

Also please don't add so many new files, life would be much easier if all
of this just went to shmem.c.  (and long-term tmpfs should maybe move to
fs/tmpfs)

