Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTBXOFw>; Mon, 24 Feb 2003 09:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbTBXOFw>; Mon, 24 Feb 2003 09:05:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25984
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267102AbTBXOFv>; Mon, 24 Feb 2003 09:05:51 -0500
Subject: Re: [PATCH][ATM] get skb->len right after adjusting head
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: davem@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302240130.h1O1UnWk027874@locutus.cmf.nrl.navy.mil>
References: <200302240130.h1O1UnWk027874@locutus.cmf.nrl.navy.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046099824.1246.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 24 Feb 2003 15:17:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 01:30, chas williams wrote:
>                  skb->dev = dev;
>                  skb->data += 2; /* skip lec_id */
> +                skb->len -= 2;

skb_pull(skb, 2) surely


