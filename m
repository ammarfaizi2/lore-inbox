Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269161AbTGJJyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbTGJJyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:54:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26124 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269161AbTGJJyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:54:19 -0400
Date: Thu, 10 Jul 2003 11:08:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Frank <mflt1@micrologica.com.hk>, daniel.ritz@gmx.ch,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: 2.5.74-mm3 yenta-socket oops back
Message-ID: <20030710110856.A1074@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Michael Frank <mflt1@micrologica.com.hk>, daniel.ritz@gmx.ch,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
References: <200307060039.34263.daniel.ritz@gmx.ch> <20030706231551.B16820@flint.arm.linux.org.uk> <200307101127.32590.mflt1@micrologica.com.hk> <20030709213010.1882a898.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030709213010.1882a898.akpm@osdl.org>; from akpm@osdl.org on Wed, Jul 09, 2003 at 09:30:10PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 09:30:10PM -0700, Andrew Morton wrote:
> This one may not be.  How did we get here with no thread to handle the
> event?  Do you have an oops trace on this one?

It's correct.  Had the fan in my server not died last night, I'd have
gotten some of these fixes to Linus.  God how I hate anything with fans
in.  They're the number one cause of failure.

The problem is that the interrupts are claimed before pcmcia has been
properly initialised, so the cs.c-private bits of pcmcia_socket aren't
setup.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

