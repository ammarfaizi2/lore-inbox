Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVGYRSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVGYRSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVGYRSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:18:35 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:64723 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261407AbVGYRSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:18:31 -0400
Date: Mon, 25 Jul 2005 13:18:29 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: "Budde, Marco" <budde_at_telos.de@engin.umich.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stripping in module
Message-ID: <Pine.LNX.4.63.0507251314440.16515@hammer.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco:

FWIW, the Red Hat kernel RPMs effectively do the following when they 
package kernel modules:

 	strip -g <module.ko>


This is done via the script:

 	/usr/lib/rpm/brp-strip


which is implicitly run on all executable files packaged in the RPM.


If you ensure that the module .ko file is executable, then RPM will strip 
it for you automatically.


-Chris Wing
wingc@engin.umich.edu



---
Budde, Marco <budde_at_telos.de> wrote:

> Hi,
> 
> at the moment I am packaging a Linux module as an RPM archive.
> 
> Therefor I would like to remove some of the not exported/needed
> symbols (like e.g. static functions or constants) from the
> Linux module.
> 
> What is the best way to do this with v2.6.
