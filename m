Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUJYPOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUJYPOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbUJYPNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:13:54 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:58380 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261933AbUJYPJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:09:41 -0400
Date: Mon, 25 Oct 2004 16:09:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 12/28] VFS: Remove (now bogus) check_mnt
Message-ID: <20041025150941.GA1682@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <1098715442105@sun.com> <10987154731896@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10987154731896@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:44:33AM -0400, Mike Waychison wrote:
> check_mnt used to be used to see if a mountpoint was actually grafted or not
> to a namespace.  This was done because we didn't support mountpoints being
> attached to one another if they weren't associated with a namespace. We now
> support this, so all check_mnt calls are bogus.  The only exception is that
> pivot_root still requires all participants to exist within the same
> namespace.

did you audit the namespace code that it doesn't allow attachign to other
namespaces than the current?

