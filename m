Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270875AbTG0QWl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270874AbTG0QWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:22:41 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:42670 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S270880AbTG0QWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:22:31 -0400
Date: Sun, 27 Jul 2003 12:24:50 -0400
From: Ben Collins <bcollins@debian.org>
To: dan carpenter <d_carpenter@sbcglobal.net>
Cc: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [bug] ieee1394/sbp2 - sleeping in invalid context
Message-ID: <20030727162450.GM490@phunnypharm.org>
References: <200307262224.13705.bhards@bigpond.net.au> <200307270346.50781.d_carpenter@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307270346.50781.d_carpenter@sbcglobal.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 03:46:50AM -0700, dan carpenter wrote:
> I think sbp2scsi_queuecommand is called from outside interrupt context.  The 
> obvious but possibly wrong way to fix this would be to change the calls to 
> hpsb_get_tlabel() to check in_atomic() instead of in_interrupt().

This is fixed in the SVN repo now. I'll push to Linus soon.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
