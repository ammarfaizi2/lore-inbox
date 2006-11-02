Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752751AbWKBX7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbWKBX7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbWKBX7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:59:17 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:24992 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1752751AbWKBX7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:59:17 -0500
Date: Fri, 3 Nov 2006 00:59:20 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061102235920.GA886@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 November 2006 22:52:47 +0100, Mikulas Patocka wrote:
>
> new method to keep data consistent in case of crashes (instead of 
> journaling),

Your 32-bit transaction counter will overflow in the real world.  It
will take a setup with millions of transactions per second and even
then not trigger for a few years, but when it hits your filesystem,
the administrator of such a beast won't be happy at all. :)

Jörn

-- 
Ninety percent of everything is crap.
-- Sturgeon's Law
