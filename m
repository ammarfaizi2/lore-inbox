Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTEMQAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTEMP6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:58:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55826 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261864AbTEMP6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:58:00 -0400
Date: Tue, 13 May 2003 17:08:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       alexander.riesen@synopsys.COM, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69+bk: "sleeping function called from illegal context" on card release while shutting down
Message-ID: <20030513170820.C15172@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	alexander.riesen@synopsys.COM, LKML <linux-kernel@vger.kernel.org>
References: <20030513135759.GG32559@Synopsys.COM> <1052837896.1000.2.camel@teapot.felipe-alfaro.com> <1052839860.2255.19.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052839860.2255.19.camel@diemos>; from paulkf@microgate.com on Tue, May 13, 2003 at 10:31:01AM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:31:01AM -0500, Paul Fulghum wrote:
> Russell's patches do not address this.

In part they do - the patch gives us a guaranteed process context for
the pcmcia event stuff.  The process context is provided in the right
place (core pcmcia code).

Things left in this area are:

- Remove workqueues from socket drivers.
- I'd like to see struct pcmcia_driver expand to include more
  functions (card removal, insertion, etc) rather than having
  an event handler.
- Remove the card removal event timers from pcmcia drivers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

