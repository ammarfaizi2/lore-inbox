Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbVALBG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVALBG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVALBG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:06:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50113 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262969AbVALBGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:06:22 -0500
Date: Tue, 11 Jan 2005 17:01:51 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Patch to fix ub looping with a tag mismatch
Message-ID: <20050112010151.GD22395@kroah.com>
References: <20050107212055.3592fcde@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107212055.3592fcde@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:20:55PM -0800, Pete Zaitcev wrote:
> If a command times out, we resubmit a retry. Some devices, however, buffer
> everything we send and then eventually reply to a command we have timed out
> already. We receive a bad tag, send a new command, device replies to the
> one sent before, and so on without end.
> 
> The fix is to flush pending replies if tags mismatch (by reading them).
> 
> Signed-off-by: Pete Zaitcev

Applied, thanks.

greg k-h

