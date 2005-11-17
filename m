Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbVKQAKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbVKQAKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbVKQAKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:10:07 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:31429 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030567AbVKQAKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:10:05 -0500
Date: Thu, 17 Nov 2005 01:06:54 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Oliver Neukum <oliver@neukum.org>, jmerkey <jmerkey@utah-nac.org>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051117000654.GA11128@wohnheim.fh-wedel.de>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <200511161630.59588.oliver@neukum.org> <1132155482.2834.42.camel@laptopd505.fenrus.org> <200511161710.05526.ak@suse.de> <20051116184508.GP5735@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051116184508.GP5735@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 November 2005 19:45:08 +0100, Adrian Bunk wrote:
> 
> Jörn did some analysis regarding possible call paths > 3k.

And most of them have been changed since.  Zlib remains high on the
list, but those paths are from /lib/inflate.c, during bootup.

What remains to be analysed is the recursions.  If someone seriously
wants to work on those, I can respin the tests.  The process is not
fully automated, so it will take me a weekend (and this weekend is
scheduled for a party).

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
