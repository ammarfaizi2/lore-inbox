Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270991AbTHOVjU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270995AbTHOVjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:39:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20232 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270991AbTHOVjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:39:19 -0400
Date: Fri, 15 Aug 2003 22:39:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ed L Cashin <ecashin@uga.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] do_wp_page: BUG on invalid pfn
Message-ID: <20030815223912.E21529@flint.arm.linux.org.uk>
Mail-Followup-To: Ed L Cashin <ecashin@uga.edu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20030815184720.A4D482CE79@lists.samba.org> <877k5e8vwe.fsf@uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <877k5e8vwe.fsf@uga.edu>; from ecashin@uga.edu on Fri, Aug 15, 2003 at 05:15:45PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:15:45PM -0400, Ed L Cashin wrote:
> +		dump_stack();
> +		BUG();

Is there much point to both dump_stack and BUG() - BUG is supposed to
provide a calltrace, which dump_stack also does.  Do we really need two
copies?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

