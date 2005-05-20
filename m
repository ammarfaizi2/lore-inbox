Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVETNkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVETNkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVETNkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:40:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28033 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261407AbVETNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:40:19 -0400
Date: Fri, 20 May 2005 14:40:46 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] vfs: increase scope of critical locked path in fget_light to avoid race
Message-ID: <20050520134046.GQ29811@parcelfarce.linux.theplanet.co.uk>
References: <20050520132325.GE19229@hmsendeavour.rdu.redhat.com> <20050520133337.GP29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520133337.GP29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 02:33:38PM +0100, Al Viro wrote:
> Er...  If we get 1, we *KNOW* who holds the only reference - that's us.
> And to change refcount of files_struct you need to hold a reference to
                       or contents
