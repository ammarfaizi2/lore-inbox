Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbTBRM5k>; Tue, 18 Feb 2003 07:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbTBRM5j>; Tue, 18 Feb 2003 07:57:39 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:28714 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267808AbTBRM5e>; Tue, 18 Feb 2003 07:57:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>, sfrench@samba.org
Subject: Re: [PATCH] Fix warnings from CIFS on 2.5.61
Date: Tue, 18 Feb 2003 07:07:42 -0600
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1045522192.12947.90.camel@dell_ss3.pdx.osdl.net>
In-Reply-To: <1045522192.12947.90.camel@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302180707.42859.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 February 2003 16:49, Stephen Hemminger wrote:

> +	pSMB->MaxCount = cpu_to_le16(min_t(const int,
> +					   count,
> +					   (tcon->ses->server->maxBuf -
> +					    MAX_CIFS_HDR_SIZE) & 0xFFFFFF00));

The type here should be const unsigned int.  Both count and maxBuf are 
unsigned.

-- 
David Kleikamp
IBM Linux Technology Center

