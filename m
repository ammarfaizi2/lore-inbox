Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTENLro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 07:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTENLro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 07:47:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17824
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261895AbTENLro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 07:47:44 -0400
Subject: Re: [PATCH 0/4] NE2000 driver updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Riley Williams <Riley@Williams.Name>
Cc: Jeff Muizelaar <muizelaar@rogers.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BKEGKPICNAKILKJKMHCACEOMCPAA.Riley@Williams.Name>
References: <BKEGKPICNAKILKJKMHCACEOMCPAA.Riley@Williams.Name>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052910126.2103.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 12:02:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-14 at 08:29, Riley Williams wrote:

> If there's going to be any problems, it's with devices claiming the
> same IOaddr as each other - and certain addresses are far too common
> where that's concerned - especially 0x0300 through 0x031F which are
> almost universal in their use !!!!!!!

This is why you have to get the ordering right. Specifically you have to
deal with probe unsafe hardware (ie ne2000) early. Once you've checked
0x300 isnt an NE2000 its generally safe to probe there, before that its
a very bad idea. Space.c knows about this and a vast amount more.


