Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272638AbTG1DoK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 23:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272639AbTG1DoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 23:44:10 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:25861 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272638AbTG1DoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 23:44:07 -0400
Date: Mon, 28 Jul 2003 05:59:20 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030728035920.GA1660@win.tue.nl>
References: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 07:13:26PM -0700, dean gaudet wrote:

> this was a bug i reported back a few versions as well -- and i don't think
> i received any responses (nor from the maintainer).
> 
> i've got a box on which 2.4.x works fine, but 2.6.0-test2 gets into a snit
> when it's trying to initialize the i8042.  i can get 2.6.0-test2 to boot
> if i add "i8042_nomux".
> 
> the mux initialization code seems kind of ... wonk -- it seems to write
> values to the registers then read back and if the value is the same then
> it assumes the mux is there.  that seems way too likely to be broken in
> situations when the mux isn't there... it'd be better to be looking for
> some value which is different after writing.

No, it writes f0, 56, a4 and if it gets f0, 56, and not a4, then it assumes
there is a mux.

[This is a Synaptics convention.]

What hardware do you have? And what is the conversation?

