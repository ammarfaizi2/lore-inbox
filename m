Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271475AbTGQOqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271476AbTGQOqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:46:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17103
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271475AbTGQOqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:46:21 -0400
Subject: Re: [PATCH] pdcraid and weird IDE geometry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Walt H <waltabbyh@comcast.net>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davzaffiro@tasking.nl
In-Reply-To: <3F16B49E.8070901@comcast.net>
References: <3F160965.7060403@comcast.net>
	 <1058431742.5775.0.camel@laptop.fenrus.com>  <3F16B49E.8070901@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 15:58:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-17 at 15:37, Walt H wrote:

> On the second drive, it's like this:
> capacity = 80418240, head=255, sect = 63
> lba = capacity / (head * sect) = 5005 int or 5005.80 float
> lba = lba * (head * sect) = 80405325 int or 80418240.01 float
> lba = lba - sect = 80405262 int or 80418177 float

Would fixed point solve this. Start from capacity <<= 16 and then
do the maths. That would put lba in 65536ths of a sector which
should have the same result as your float maths

