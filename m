Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUIBLFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUIBLFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIBLFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:05:22 -0400
Received: from denise.shiny.it ([194.20.232.1]:2275 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S268212AbUIBLCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:02:11 -0400
Date: Thu, 2 Sep 2004 13:00:49 +0200 (CEST)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Spam <spam@tnonline.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <812032218.20040902120259@tnonline.net>
Message-ID: <Pine.LNX.4.58.0409021252430.7698@denise.shiny.it>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org>
 <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
 <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
 <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com>
 <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com>
 <812032218.20040902120259@tnonline.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Spam wrote:

>   Well. wasn't the idea that unless programs specifically tried to
>   open the file-as-dir as a directory it would look like a file?
>
>   ls -F would show it as file. Or have I understood wrong?

Yes, otherwise apps that do

if (S_ISDIR()) {
	..
} else if (S_ISREG()) {
	..
}

would behave differently from apps that check the file in
different order, and they would probably break because in
a regular fs that order is not important. The goal is to
keep the semantic changes as hidden as possible for apps
that don't know about the new features.


--
Giuliano.
