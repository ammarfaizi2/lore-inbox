Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbUKPGmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUKPGmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 01:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUKPGmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 01:42:44 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:45804 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261928AbUKPGmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 01:42:09 -0500
Date: Mon, 15 Nov 2004 22:41:51 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] [PATCH] uml: fail xterm_open when we have no $DISPLAY
Message-ID: <20041116064151.GB22588@taniwha.stupidest.org>
References: <20041115032541.GA13077@taniwha.stupidest.org> <200411151824.29365.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411151824.29365.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 06:24:29PM +0100, Blaisorblade wrote:

> Thanks for drawing attention on this! I hadn't had the time to dig
> this out...  for now reasonably correct

it's a partial solution, in general more is required

> but no time to review it properly now. The review would probably try
> to find a more direct fix to this...

catch the xterm process dying, up(&data->sem), and -EIO all requests
from that point onwards I guess.  That applies for some of the other
channels too, some of the code would probably be abstracted a little
and generalized I guess.



   --cw
