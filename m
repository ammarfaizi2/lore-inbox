Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTB0QPK>; Thu, 27 Feb 2003 11:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTB0QPK>; Thu, 27 Feb 2003 11:15:10 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:37340 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S265612AbTB0QPJ>; Thu, 27 Feb 2003 11:15:09 -0500
To: Kevin Corry <corryk@us.ibm.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] dm: prevent possible buffer overflow in ioctl interface
References: <200302262104.h1QL4aiC001941@eeyore.valparaiso.cl>
	<03022708205903.05199@boiler> <03022708365304.05199@boiler>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 27 Feb 2003 08:25:25 -0800
In-Reply-To: <03022708365304.05199@boiler>
Message-ID: <52y941pu6i.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Feb 2003 16:25:27.0703 (UTC) FILETIME=[D6927A70:01C2DE7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   > +	char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1);
   > +	if (!name) {
   > +		return -ENOMEM;
   > +	}

Also, kmalloc() needs a second "GFP_xxx" parameter (I guess GFP_KERNEL
in this case, although I don't know the context this function is
called from).

 - Roland

