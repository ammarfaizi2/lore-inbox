Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVA3RIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVA3RIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVA3RIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:08:05 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:28235 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261739AbVA3RF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:05:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=m9XfBDIhf8PwWNBe88lcB+wcD0Y9NVM0Wl3XiWmkgreZy1QG6J13o2QUAANklgT/pAUgRunZ+QuE+mxatYH0ENQOyJ9iejo1rtxNsVRxQzKJhf0pIHBBXGVtFaHUSTQGG7lpR/ouENJEtUJIxZpszsNkBhIrNp/reiFkEMe3rWs=
Message-ID: <9e473391050130090532067a5f@mail.gmail.com>
Date: Sun, 30 Jan 2005 12:05:27 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search result
Cc: Dave Airlie <airlied@gmail.com>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050130163241.GA18036@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no>
	 <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
	 <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no>
	 <20050130111634.GA9269@hh.idb.hist.no>
	 <21d7e9970501300322ffdabe0@mail.gmail.com>
	 <9e473391050130070520631901@mail.gmail.com>
	 <20050130163241.GA18036@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005 17:32:41 +0100, Helge Hafting
<helgehaf@aitel.hist.no> wrote:
> Yes, it is a PCI radeon.  And the machine has an AGP slot
> too, which is used by a matrox G550.  This AGP card was not
> used in the test, (other than being the VGA console).
> Note that there is no crash if I don't compile
> AGP support, so the crash is related to AGP somehow even though
> AGP is not supposed to be used in this case.

Can you set the PCI card to be primary in your BIOS or remove the AGP
card, and then see if it works? It could be that X's video reset code
for secondary PCI cards is broken.

-- 
Jon Smirl
jonsmirl@gmail.com
