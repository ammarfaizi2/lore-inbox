Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319085AbSIJJHf>; Tue, 10 Sep 2002 05:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319086AbSIJJHe>; Tue, 10 Sep 2002 05:07:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64523 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319085AbSIJJHe>; Tue, 10 Sep 2002 05:07:34 -0400
Date: Tue, 10 Sep 2002 10:12:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disabled kernel.org accounts
Message-ID: <20020910101215.A11778@flint.arm.linux.org.uk>
References: <18629.1031548515@kao2.melbourne.sgi.com> <alhvk4$obf$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <alhvk4$obf$1@forge.intermeta.de>; from hps@intermeta.de on Mon, Sep 09, 2002 at 11:11:00AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 11:11:00AM +0000, Henning P. Schmiedehausen wrote:
> Well, the reason for this are missing NS records:

Works fine for me.

> So they're a really, really crappy ISP. Maybe they're cheap so
> everyone uses them...

Actually, its a result of new bind9 behaviour.  Previous versions of
bind used the glue records from the upper level DNS servers.  bind9
no longer trusts this glue information and will go looking for the
records in the right zone.

I've been bitten by this when trying to mail someone (their domain
had the NS records but not the corresponding A records for their name
servers.)  BTinternet have also been bitten by this when they upgraded
to bind9.  Welcome to bind9. 8)

And the annoying thing is that people running the domains with the
problems will normally point you at some web based DNS checker that
only tests for half the things it should do, and they completely
believe its output as being 100% correct.  The typical response you
get is "It passes www.xyz.com's DNS tests, its your problem."

Its in the same problem space as getting everyone to accept ICMP
fragmentation needed messages, or getting ECN to work.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

