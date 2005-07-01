Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263300AbVGAKEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbVGAKEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 06:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbVGAKET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 06:04:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38411 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263300AbVGAKEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 06:04:16 -0400
Date: Fri, 1 Jul 2005 11:04:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: domen@coderock.org, Al Viro <viro@zenII.uk.linux.org>
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>
Subject: Re: [patch 1/1] sizeof(*dev) : arch/arm/common/sa1111.c
Message-ID: <20050701110403.A13198@flint.arm.linux.org.uk>
Mail-Followup-To: domen@coderock.org, Al Viro <viro@ftp.uk.linux.org>,
	linux-kernel@vger.kernel.org,
	Christophe Lucas <clucas@rotomalug.org>
References: <20050630215819.226570000@>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050630215819.226570000@>; from domen@coderock.org on Thu, Jun 30, 2005 at 11:58:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 11:58:19PM +0200, domen@coderock.org wrote:
> when using sizeof consider using the variable and not the type, that way
> if the type of the variable is changed we don't have to go seaching
> all instances of sizeof(type).

This is a matter of taste, and I decided upon sizeof(type) after a
discussion with Al Viro on this subject.

I believe the overwealming argument for sizeof(type) as opposed to
sizeof(expression) is that you can identify easily where likely
initialisations happen, and therefore places which need to be
properly updated if/when you change the type.

I'm also sending this to Al so he can give his point of view on
sizeof(type) vs sizeof(expression).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
