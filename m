Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTICXcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTICXcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:32:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53995 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264266AbTICXcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:32:02 -0400
Message-ID: <3F5679E1.8090604@pobox.com>
Date: Wed, 03 Sep 2003 19:31:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: "David S. Miller" <davem@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.0-test4-mm5
References: <20030902231812.03fae13f.akpm@osdl.org>	 <20030903161200.GC23729@fs.tum.de>  <3F5617A9.4040603@pobox.com> <1062607559.1785.50.camel@gaston>
In-Reply-To: <1062607559.1785.50.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> BTW. David: Any reason why you wouldn't let me change all occurences
> of spin_{lock,unlock}_irq into the ...{save,restore} versions ?


IMO... even though you do lose a tiny bit of performance, I definitely
prefer the save/restore versions.

It allows the arch a lot more flexibility, so I even have a [weak]
argument that {save,restore} variants increase portability.  And it's
safer, as I like to avoid code which winds up doing (as it passes
through layers) spin_unlock_irq() followed by spin_unlock_irqrestore().

	Jeff




