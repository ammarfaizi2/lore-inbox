Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTEFMLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbTEFMLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:11:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61862
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262645AbTEFMLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:11:10 -0400
Subject: Re: Failing to allocated file handles?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Harris <jamie.harris@eduserv.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4AF1125777E862438AF19388C54860C9220553@exch.office.niss.ac.uk>
References: <4AF1125777E862438AF19388C54860C9220553@exch.office.niss.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052220312.28792.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 12:25:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 09:40, Jamie Harris wrote:
> It appears that the system is not allocating new file handles fast
> enough to keep up with the rate they are being consumed.  Is this
> possible?  I'm unable to replicated this on a single processor machine
> so am assuming that it's related to different threads on different CPUs
> not 'keeping up with one another'.  

Seems wildly improbable. And if you've reached the max file limit you
set why do you expect the kernel to exceed it. Given the max files is
set based on the system memory I'd put my bet on it being a low memory
box that hits the problem. If so just write a bigger value to the
setting

