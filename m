Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTEZR7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTEZR7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:59:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20427
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261968AbTEZR7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:59:31 -0400
Subject: Re: Linux 2.4.21-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Martijn Uffing <mp3project@jorg.student.utwente.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Russell Coker <russell@coker.com.au>
In-Reply-To: <3ECE1DBF.5090602@gmx.net>
References: <Pine.LNX.4.44.0305231437260.28118-100000@cam029208.student.utwente.nl>
	 <3ECE1DBF.5090602@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053969090.16694.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 May 2003 18:11:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-23 at 14:10, Carl-Daniel Hailfinger wrote:
> Martijn Uffing wrote:
> > Ave
> > 
> > Modular ide is still broken in 2.4.21-rc3  with my config.
> 
> IIRC, Alan said it is not suposed to work yet. However, if you're
> feeling brave (and have no valuable data), you can try to export these
> symbols to make depmod happy. (Please read on)

Thats the problem - you can't. You have to link the ide core code into one
file, which itself is easy (now I've fixed the pdc4030 in my tree) except
fo the cmd640 vlb hooks which are nasty as it sucks in a driver from a sub
directory.

That one is the remaining horror and I'm not sure how best to tackle it

