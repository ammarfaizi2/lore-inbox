Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTFEEuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 00:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTFEEuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 00:50:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49630 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264461AbTFEEuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 00:50:13 -0400
Date: Wed, 04 Jun 2003 22:01:17 -0700 (PDT)
Message-Id: <20030604.220117.26306541.davem@redhat.com>
To: torvalds@transmeta.com
Cc: albert@users.sourceforge.net, linux-kernel@vger.kernel.org,
       bcollins@debian.org, wli@holomorphy.com, tom_gall@vnet.ibm.com,
       anton@samba.org
Subject: Re: /proc/bus/pci
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0306042117440.2761-100000@home.transmeta.com>
References: <1054783303.22104.5569.camel@cube>
	<Pine.LNX.4.44.0306042117440.2761-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 4 Jun 2003 21:23:16 -0700 (PDT)
   
   On Wed, 4 Jun 2003, Albert Cahalan wrote:
   > bus/pci/00/00.0 -> ../hose0/bus0/dev0/fn0/config-space
   
   Why do we have that stupid "hose" name? Only because of strange alpha 
   naming, or did somebody else also use that incredibly silly name?
   
   Please talk about "domains", at least it makes some sense as a name.

I agree.
   
   I'm also hoping that /proc/bus will eventually go away, so I don't
   see a major problem with not understanding multiple domains at that
   level.
   
   On a /sys/bus/xxx level we actually should already be able to handle 
   multiple domains, but the naming is broken. However, in /sys we should be 
   able to nicely handling non-zero domains by just extending the name space 
   a bit.
   
My only concern is what file lookup algorithm we should be encouraging
things like xfree86 to use.  Check /sys then /proc/bus?
