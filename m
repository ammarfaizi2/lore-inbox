Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTFDRwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTFDRwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:52:40 -0400
Received: from dan.arc.nasa.gov ([143.232.69.77]:34177 "EHLO rudi.arc.nasa.gov")
	by vger.kernel.org with ESMTP id S263726AbTFDRwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:52:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dan Christian <Daniel.A.Christian@NASA.gov>
Reply-To: Daniel.A.Christian@NASA.gov
Organization: NASA Ames Research Center
To: "John Appleby" <john@dnsworld.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
Date: Wed, 4 Jun 2003 11:06:01 -0700
User-Agent: KMail/1.4.3
References: <434747C01D5AC443809D5FC5405011314BEC@bobcat.unickz.com>
In-Reply-To: <434747C01D5AC443809D5FC5405011314BEC@bobcat.unickz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306041106.01316.Daniel.A.Christian@NASA.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 09:20, John Appleby wrote:
> > No, I didn't do "make mrproper".  I'll try that.
> >
> > It used to be that it wasn't needed and it liked to blow away
> > .config (an extreme mis-feature if I ever saw one).
>
> Not a mis-feature for those making diffs on the kernel tree and not
> wanting their .config to be included erroneously :)
>
> Regards,
>
> John

"make mrproper" fixes it.

For the record, I think this stinks!

"make mrproper" should  be an expert only utility because it does blow 
away valuable configuration information (a painfull lesson that can 
only be learned "the hard way", since the README neglicts to mention 
this).  For that matter, the README makes it look like creating a 
config from scratch (all 1500+ options) is no big deal!

"make clean; make dep" should have been enough for any config changes 
(it used to be in the past).

-Dan
