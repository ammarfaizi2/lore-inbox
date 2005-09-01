Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVIAPpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVIAPpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVIAPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:45:52 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:59570 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030211AbVIAPpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:45:51 -0400
Subject: Re: State of Linux graphics
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43171D33.9020802@tungstengraphics.com>
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
	 <1125512970.4798.180.camel@evo.keithp.com>
	 <20050831200641.GH27940@tuolumne.arden.org>
	 <1125522414.4798.222.camel@evo.keithp.com>
	 <20050901015859.GA11367@tuolumne.arden.org>
	 <1125547173.4798.289.camel@evo.keithp.com>
	 <43171D33.9020802@tungstengraphics.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Sep 2005 17:09:51 +0100
Message-Id: <1125590991.15768.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-01 at 09:24 -0600, Brian Paul wrote:
> If the blending is for screen-aligned rects, glDrawPixels would be a 
> far easier path to optimize than texturing.  The number of state 
> combinations related to texturing is pretty overwhelming.

As doom showed however once you can cut down some of the combinations
particularly if you know the texture orientation is limited you can
really speed it up.

Blending is going to end up using textures onto flat surfaces facing the
viewer which are not rotated or skewed.

