Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWGAAOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWGAAOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWGAAOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:14:08 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:4394 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932441AbWGAAOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:14:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ixspz8R8Y6MXT8gg+TtaJKRWDAcinWivm3UHH1qV+qUptG0O4ZkJmP2N8Ue5GN9s1VW+et8wibOBbiFyH3kk/pGnn7am1b3pHrSenQs1XBV2NECbxZl63qZ1JMi7rHiovcdZmVjLgPu/U8n07UeNurbRYlnvibEUrqgXF7MxcB8=
Message-ID: <a44ae5cd0606301714h5890718and0062354f4870c65@mail.gmail.com>
Date: Fri, 30 Jun 2006 17:14:05 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com>
	 <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu>
	 <20060630091850.GA10713@elte.hu>
	 <20060630111734.GA22202@gondor.apana.org.au>
	 <20060630113758.GA18504@elte.hu>
	 <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com>
	 <20060630203804.GA1950@elte.hu>
	 <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i just hit this again.  The stacktrace is identical except for this bit:

other info that might help us debug this:

2 locks held by usplash_write/2182:
 #0:  (&tty->atomic_write_lock){--..}, at: [<c11fff5e>]
mutex_lock_interruptible+0x1c/0x1f
 #1:  (&dev->_xmit_lock){-+..}, at: [<c11a5118>] dev_queue_xmit+0x183/0x24b
