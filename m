Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWJWRct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWJWRct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWJWRct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:32:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63129 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932209AbWJWRct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:32:49 -0400
Subject: Re: [PATCH] do not compile AMD Geode's hwcrypto driver as a module
	per default
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: petkov@math.uni-muenster.de
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       info-linux@geode.amd.com
In-Reply-To: <20061023170931.GB21995@gollum.tnic>
References: <20061021081745.GA6193@zmei.tnic>
	 <1161602705.19388.22.camel@localhost.localdomain>
	 <20061023170931.GB21995@gollum.tnic>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 18:35:34 +0100
Message-Id: <1161624935.21701.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-23 am 19:09 +0200, ysgrifennodd Borislav Petkov:
> ... should the duration of the the kernel compilation be prolonged then by 
> unneeded modules? Does the majority of people really use that crypto hardware or
> is it a small percentage only, we don't know but it also doesn't seem pretty sensible to do
> 'make oldconfig' and go and turn off all modules that I don't need/have by hand;
> it gets quite annoying sometimes too.

Every person has a unique and individual definitionof "un-needed
module". In addition developers want more to be compiled as it helps
catch errors earlier. Thus there are reasons for things defaulting to
"on" a lot of the time.

Also bear in mind that you can copy ".config" files between releases and
make oldconfig quite easily so you only have to turn it off once. 

It would be far more productive IMHO to write a tool which generates
a .config file by inspecting the kernel source and the machine upon
which the script is run. This could use the extracted pci data tables in
the modules to produce a correct minimal kernel for many systems.

Alan

