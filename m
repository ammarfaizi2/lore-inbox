Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSDJKDY>; Wed, 10 Apr 2002 06:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312314AbSDJKDX>; Wed, 10 Apr 2002 06:03:23 -0400
Received: from c2ce9fba.adsl.oleane.fr ([194.206.159.186]:19845 "EHLO
	avalon.france.sdesigns.com") by vger.kernel.org with ESMTP
	id <S312269AbSDJKDX>; Wed, 10 Apr 2002 06:03:23 -0400
To: linux-kernel@vger.kernel.org
Subject: module programming smp-safety howto?
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 10 Apr 2002 12:03:23 +0200
Message-ID: <7w7knf98gk.fsf@avalon.france.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm responsible for the development of a kernel module for Sigma
Designs EM84xx PCI chips (MPEG2 and MPEG4 hardware decoder
boards). It's working properly now, irq sharing and multiple board
support is ok.

I would like to make it smp-safe.

For instance, I use at a place cli()/restore to implement something that
looks like a critical section (first code path is in a ioctl, second
in a irq top half). I guess this approach is wrong with smp.

Is there some documentation or howto about what changes compared
to non-smp computers?

Maybe a specific kernel module can be considered as a good model?

Sincerely yours,

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
