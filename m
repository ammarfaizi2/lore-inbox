Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293583AbSCFO0A>; Wed, 6 Mar 2002 09:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293589AbSCFOZu>; Wed, 6 Mar 2002 09:25:50 -0500
Received: from mnh-1-28.mv.com ([207.22.10.60]:11013 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293583AbSCFOZk>;
	Wed, 6 Mar 2002 09:25:40 -0500
Message-Id: <200203061426.JAA01801@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: David Woodhouse <dwmw2@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Wed, 06 Mar 2002 10:49:52 GMT."
             <505.1015411792@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 09:26:44 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dwmw2@infradead.org said:
> Does UML somehow give pages back to the host when
> they're  freed, so the pages that are no longer used by UML can be
> discarded by the  host instead of getting swapped?

No, but it could.  Given another hook (in free_pages this time) I could unmap
pages as they're freed, allowing them to be discarded on the host.

				Jeff

