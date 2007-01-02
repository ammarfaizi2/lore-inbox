Return-Path: <linux-kernel-owner+w=401wt.eu-S1755259AbXABEHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbXABEHz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 23:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbXABEHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 23:07:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:39720 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259AbXABEHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 23:07:54 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: segher@kernel.crashing.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, jg@laptop.org
In-Reply-To: <20070101.005714.35017753.davem@davemloft.net>
References: <20061231.024917.59652177.davem@davemloft.net>
	 <20061231154103.GA7409@infradead.org>
	 <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>
	 <20070101.005714.35017753.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 15:05:59 +1100
Message-Id: <1167710760.6165.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The filesystem bit is for groveling around and getting information
> from the shell prompt, or shell scripts.  Text processing.
> 
> If you want the binary bits, export it with something like
> /dev/openprom.  We don't generally export binary representation
> files out of /proc or /sys, in fact this rule I believe is layed
> our precisely somewhere at least in the sysfs case.

Well, on powerpc, we've always had it binary. We expose the files with
the exact binary content of the properties. We then use paulus' "lsprop"
tool which is installed by default on pretty much all ppc distros, which
duplicates OF's heuristics to display property contents (as strings, hex
values or mix of both depending on that they contain).

It has proved a good idea in general as I can easily get an exact
device-tree dump from users by asking for a tarball of /proc/device-tree
and in some case, the data in there -is- binary (For example, the EDID
properties for monitors left by video drivers, or things like that).

Ben.


