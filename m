Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274983AbTHFXVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274991AbTHFXVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:21:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54925 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S274983AbTHFXVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:21:35 -0400
Message-ID: <3F318D73.3000809@pobox.com>
Date: Wed, 06 Aug 2003 19:21:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: devinit
References: <3F315CDD.12EB17FE@hp.com> <20030806230919.GB8187@kroah.com>
In-Reply-To: <20030806230919.GB8187@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I've applied the 2.6 patch to my trees and will send it on to Linus in a
> few days, thanks.


Speaking of PCI... are we gonna have to zap __devinit too?  Another 
option is to think of add-new-pci-ids-on-the-fly as a CONFIG_HOTPLUG 
feature, which should(?) maintain the current __devinit semantics: no 
re-probes.

OTOH, __devinit already is a no-op for CONFIG_HOTPLUG cases (read: most 
everybody), so I wonder if we care enough about __devinit anymore?  I 
used the same logic to support __devinitdata removal, after all.


	Jeff



