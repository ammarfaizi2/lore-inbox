Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293606AbSCEEiy>; Mon, 4 Mar 2002 23:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293604AbSCEEip>; Mon, 4 Mar 2002 23:38:45 -0500
Received: from mnh-1-27.mv.com ([207.22.10.59]:19979 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293606AbSCEEig>;
	Mon, 4 Mar 2002 23:38:36 -0500
Message-Id: <200203050440.XAA07022@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 23:28:06 EST."
             <20020304232806.A31622@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 23:40:29 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcrl@redhat.com said:
> From your explanation of things, you only need to do the memsets once
> at  startup of UML where the ram is allocated -> a uml booted with
> 64MB of  ram would write into every page of the backing store file
> before even  running the kernel.  Doesn't that accomplish the same
> thing?

Sort of, but it's very heavy-handed.  The UML will force memory to be
allocated on the host long before it will ever be needed, and it may never
be needed.  This patch doesn't waste memory like that.

				Jeff

