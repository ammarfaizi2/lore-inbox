Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbTFWLLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbTFWLLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:11:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22284 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266004AbTFWLLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:11:46 -0400
Date: Mon, 23 Jun 2003 12:25:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MOD_DEC_USE_COUNT is deprecated
Message-ID: <20030623122548.B28325@flint.arm.linux.org.uk>
Mail-Followup-To: Jan De Luyck <lkml@kcore.org>,
	linux-kernel@vger.kernel.org
References: <200306231316.21018.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200306231316.21018.lkml@kcore.org>; from lkml@kcore.org on Mon, Jun 23, 2003 at 01:16:21PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 01:16:21PM +0200, Jan De Luyck wrote:
> Little question: With many modules I'm still seeying the MOD_DEC_USE_COUNT is 
> deprecated message. I've checked the changes that have been done earlier, and 
> they usually just consist of removing these lines. If so, I'm more than 
> willing to "search and destroy" those and send 'em over to the patch monkey, 
> but if what I'm saying is totally idiotic just slap me ;p

It's not that simple - you need to ensure that there are mechanisms
in place to ensure that module unloading is safe before removing these.

The remaining MOD_{INC,DEC}_USE_COUNT act as markers for code that needs
to be fixed up.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

