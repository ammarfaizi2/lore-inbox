Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285287AbRLFXSi>; Thu, 6 Dec 2001 18:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285289AbRLFXS3>; Thu, 6 Dec 2001 18:18:29 -0500
Received: from t2.redhat.com ([199.183.24.243]:8955 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285287AbRLFXSN>; Thu, 6 Dec 2001 18:18:13 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.31.0112062004520.2339-100000@eduserv.rug.ac.be> 
In-Reply-To: <Pine.GSO.4.31.0112062004520.2339-100000@eduserv.rug.ac.be> 
To: Frank Cornelis <Frank.Cornelis@rug.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: list_head makes me crazy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 23:17:39 +0000
Message-ID: <16634.1007680659@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Frank.Cornelis@rug.ac.be said:
>  I really need this, so if anyone has the solution to my problem... 

Unfortunately, linux/list.h includes asm/processor.h, via linux/prefetch.h. 
Making them include each other is not going to work very well.

The include files need a fairly hefty shakeup in 2.5.

--
dwmw2


