Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTEMVFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTEMVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:05:05 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:23202 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262034AbTEMVFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:05:02 -0400
Date: Tue, 13 May 2003 17:17:49 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
Message-ID: <20030513211749.GA340@gnu.org>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv> <buou1bz7h9a.fsf@mcspd15.ucom.lsi.nec.co.jp> <Pine.LNX.4.44.0305131710280.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305131710280.5042-100000@serv>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:27:30PM +0200, Roman Zippel wrote:
> With the new patch this will work. The effect is basically the same as if 
> you would add "enable RTE_CB_MULTI" to RTE_CB_MA1 - RTE_CB_MULTI is 
> visible but you cannot change it.

I see.

BTW, the name `enable' seems to be a misnomer -- `enable' implies that it
forces the depends to be y, but not that it also forces the _value_.

Why not have two:

  enable FOO	- forces the `depends' value of FOO to y
		  but it will still prompt
  force FOO	- forces both the `depends' and value of FOO to y
		  prompting for FOO is turned off

-Miles
-- 
We are all lying in the gutter, but some of us are looking at the stars.
-Oscar Wilde
