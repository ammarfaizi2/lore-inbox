Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270093AbTGXUnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 16:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271725AbTGXUnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 16:43:33 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51216 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270093AbTGXUnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 16:43:32 -0400
Date: Thu, 24 Jul 2003 22:58:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: passing my own compiler options into linux kernel compiling
Message-ID: <20030724205837.GA1176@mars.ravnborg.org>
Mail-Followup-To: Michal Semler <cijoml@volny.cz>,
	linux-kernel@vger.kernel.org
References: <200307240916.17530.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307240916.17530.cijoml@volny.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 09:16:17AM +0200, Michal Semler wrote:
> Hello,
> 
> I use gcc-3.3 and I would like compile my kernel with flags:
> 
> -O4 -march=pentium3 -mcpu=pentium3
> 
> Is there any way to do this?
Only way to specify -O4 is to manually edit top-level Makefile.
Change the assignment to CFLAGS (not hOSTCFLAGS as someone suggested).

The -m options are set in arch/i386/Makefile.
The best way to set them is to select the correct processor type.

	Sam
