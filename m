Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTEVKfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 06:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTEVKfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 06:35:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31936
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262245AbTEVKfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 06:35:21 -0400
Subject: Re: [CHECKER] 12 potential leaks in kernel 2.5.69
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Ted Kremenek <kremenek@cs.stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
In-Reply-To: <20030522100358.GB6708@wohnheim.fh-wedel.de>
References: <BAF1B694.8EBC%kremenek@cs.stanford.edu>
	 <20030522100358.GB6708@wohnheim.fh-wedel.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053597009.2534.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 May 2003 10:50:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >             schedule();
> >             barrier();
> 
> Iirc, the above will leak 4 bytes (plus overhead) once per kernel
> boot and controller. This only happens for broken hardware and the
> alternative is memory corruption, depending on how broken the hardware
> is. Wontfix.
> 
> Alan, was that correct?

It should only leak in the error path case. If the controller didnt reply
then it still owns that ram and for the sake of a few bytes its better to 
play safe yes

