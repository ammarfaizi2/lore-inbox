Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUJSJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUJSJXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268104AbUJSJXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:23:14 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:20923 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268101AbUJSJXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:23:11 -0400
Date: Tue, 19 Oct 2004 11:23:07 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: SOLVED: 2.6.9 BK build broken
Message-ID: <20041019092307.GA13868@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041019021719.GA22924@merlin.emma.line.org> <41747CA6.7030400@pobox.com> <41748ADE.70403@pobox.com> <Pine.LNX.4.58.0410182208020.2287@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410182208020.2287@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Linus Torvalds wrote:

> I bet the thing is fixed by changing the
> 
> 	#define __builtin_warning(x, ...) (1)
> 
> into
> 
> 	#define __builtin_warning(x, y...) (1)

Indeed it is. I just did bk pull and found that
torvalds@ppc970.osdl.org|ChangeSet|20041019071619|06021
compiles fine on gcc-3.3.4, 3.4.2 and SuSE's gcc-3.3.3-41.

Thank you.

-- 
Matthias Andree
