Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWDVUJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWDVUJk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWDVUJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:09:40 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:43208 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751130AbWDVUJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:09:38 -0400
Date: Sat, 22 Apr 2006 13:56:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kfree(NULL)
Message-ID: <20060422115601.GB6629@wohnheim.fh-wedel.de>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com> <Pine.LNX.4.61.0604211643350.31515@yvahk01.tjqt.qr> <20060421192217.GI19754@stusta.de> <200604211330.30657.vernux@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200604211330.30657.vernux@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 April 2006 13:30:30 -0700, Vernon Mauery wrote:
> 
> A simple NULL check is faster 
> than a function call and then a simple NULL check.

I am not sure whether this is still true for any non-ancient CPUs.
The cost of a branch misprediction is in the order of _many_
predictable instructions.  That makes conditionals more expensive than
they used to be.  And the cost of branch mispredictions keeps
increasing.

Jörn

-- 
You can take my soul, but not my lack of enthusiasm.
-- Wally
