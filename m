Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUBKJwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 04:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUBKJwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 04:52:37 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:26643 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263898AbUBKJwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 04:52:36 -0500
Message-ID: <4029FE68.9020206@aitel.hist.no>
Date: Wed, 11 Feb 2004 11:05:28 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Matthew Reppert <repp0017@tc.umn.edu>
CC: Mike Bell <kernel@mikebell.org>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
References: <20040210113417.GD4421@tinyvaio.nome.ca>	 <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca>	 <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca>	 <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca> <1076451567.21725.21.camel@minerva>
In-Reply-To: <1076451567.21725.21.camel@minerva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Reppert wrote:

> At the very least, sysfs' and devfs' approaches to devices differ in
> philosophy. devfs says "here's a device node, you can tell where it is
> in the bus hierarchy by looking at its filename". sysfs, on the other
> hand, says "here's the device hierarchy", and gives you enough information
> to create device nodes for each point in the hierarchy if you wish to do
> so.
> 
There's an interesting security implication here.  I used to think 
"why don't they make a device node instead of exporting
numbers, udev could then simply make a link to it"
It'd be simpler, and the minimalists could use the node in sysf directly.

The security advantage is that we don't get a device with some default
permissions that might get abused.  The udev config can decide
to create a node with stricter than usual permissions, or decide
to not make the node at all.

Helge Hafting

