Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVCKBGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVCKBGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 20:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVCKBGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 20:06:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:49365 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263032AbVCKBFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 20:05:11 -0500
Subject: Re: [AGPGART] Map the graphic card to the bridge its connected to.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: davej@redhat.com, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1110495771.32525.287.camel@gaston>
References: <200503070222.j272MJai027858@hera.kernel.org>
	 <1110495771.32525.287.camel@gaston>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 11:59:46 +1100
Message-Id: <1110502787.32525.306.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 10:02 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-02-23 at 02:25 +0000, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1982.82.19, 2005/02/22 21:25:33-05:00, davej@delerium.kernelslacker.org
> > 
> > 	[AGPGART] Map the graphic card to the bridge its connected to.
> > 	
> > 	Signed-off-by: Dave Jones <davej@redhat.com>

Note that the effect of reverting the patch gets a broken result too
(btw... the code had a spurrious pci_dev_put() too ...)

Anyway, paulus is working on a solution that should be good enough for
both cases where the AGP bridge is a sibling of the device, and where
the bridge is a parent of the device. Patch soon...

Ben.


