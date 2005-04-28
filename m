Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVD1Rqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVD1Rqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVD1Rqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:46:36 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6051 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262196AbVD1Ro5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:44:57 -0400
Subject: Re: [RFC/PATCH 0/5] read/write on attribute w/o show/store should
	return -ENOSYS
From: Robert Love <rml@novell.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20050428173744.GO23013@shell0.pdx.osdl.net>
References: <200504280030.10214.dtor_core@ameritech.net>
	 <20050428172659.GA18859@kroah.com>
	 <20050428173744.GO23013@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 13:44:32 -0400
Message-Id: <1114710272.6682.63.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 10:37 -0700, Chris Wright wrote:

> SuSv3 suggests EBADF, however we already do EINVAL at VFS for no write
> op.  Although, returning 0 (i.e. wrote zero bytes) is still meaningful
> too.

I think EBADF implies that you opened the thing not for writing, and now
you are trying to write to it.

But my understanding of this problem is that the open is succeeding for
writes, but when the actual write is performed, the store fails (or does
not exist).

EIO makes sense for that.  EACCESS less so, but still some.

	Robert Love


