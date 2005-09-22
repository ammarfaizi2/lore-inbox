Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVIVVyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVIVVyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVIVVyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:54:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12708 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751280AbVIVVyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:54:52 -0400
Date: Thu, 22 Sep 2005 14:54:31 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <20050922144619.05bebbbb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509221448360.18810@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz> <20050916023005.4146e499.akpm@osdl.org>
 <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org>
 <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org>
 <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
 <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
 <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
 <Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com>
 <4330B5C2.3080300@vc.cvut.cz> <Pine.LNX.4.62.0509210856410.10272@schroedinger.engr.sgi.com>
 <Pine.LNX.4.62.0509221250120.17975@schroedinger.engr.sgi.com>
 <20050922130150.0822b882.akpm@osdl.org> <43332161.20806@vc.cvut.cz>
 <20050922144619.05bebbbb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Andrew Morton wrote:

> Great, thanks.   Christoph, was that patch the final official version?

This should deal with the node ownership issue. So yes.

I still have some open question on how pages ended up on the wrong node.
This should only happen if a zone / node has run out of memory. If pages 
ended up on the wrong node without that then there may be a different 
issue still to be fixed.

Maybe Petr can give us some more details on when the problem occurs?
