Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWJ2Pul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWJ2Pul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 10:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWJ2Pul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 10:50:41 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:40336 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S965248AbWJ2Pui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 10:50:38 -0500
X-Originating-Ip: 72.57.81.197
Date: Sun, 29 Oct 2006 10:48:43 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: why test for "__GNUC__"?
In-Reply-To: <20061029120534.GA4906@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0610291044230.9726@localhost.localdomain>
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain>
 <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain>
 <20061029120534.GA4906@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006, Alexey Dobriyan wrote:

> On Sun, Oct 29, 2006 at 07:44:18AM -0500, Robert P. J. Day wrote:
> > p.s.  is there, in fact, any part of the kernel source tree that has a
> > preprocessor directive to identify the use of ICC?  just curious.
>
> Please, do
>
> 	ls include/linux/compiler-*

but according to compiler.h:

/* Intel compiler defines __GNUC__. So we will overwrite implementations
 * coming from above header files here
 */

so even ICC will define __GNUC__, which means that testing for
__GNUC__ is *still*, under the circumstances, redundant, isn't that
right?

rday
