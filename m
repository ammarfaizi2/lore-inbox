Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269774AbUJGKQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269774AbUJGKQC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269779AbUJGKQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:16:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11790 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269774AbUJGKPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:15:52 -0400
Date: Thu, 7 Oct 2004 11:15:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.9-rc3-mm3
Message-ID: <20041007111541.D10716@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
References: <20041007015139.6f5b833b.akpm@osdl.org> <Pine.LNX.4.61.0410071159010.13059@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0410071159010.13059@jjulnx.backbone.dif.dk>; from juhl-lkml@dif.dk on Thu, Oct 07, 2004 at 12:04:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 12:04:22PM +0200, Jesper Juhl wrote:
> After recieving some feedback from Christoph Hellwig I believe this is 
> probably a better version of the patch (no reason not to use the 
> access_ok checking version of copy_to_user) :

Except that we've validated the user pointer _before_ performing any
of the ioctl handling itself, so the non-__ copy_to_user is fairly
redundant.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
