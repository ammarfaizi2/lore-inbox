Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWEJPDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWEJPDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWEJPDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:03:30 -0400
Received: from [63.81.120.158] ([63.81.120.158]:17033 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964966AbWEJPD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:03:29 -0400
Subject: Re: [PATCH -mm] megaraid gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, Seokmann.Ju@lsil.com, linux-kernel@vger.kernel.org
In-Reply-To: <1147273719.17886.43.camel@localhost.localdomain>
References: <200605100256.k4A2u3lB031731@dwalker1.mvista.com>
	 <1147257558.17886.8.camel@localhost.localdomain>
	 <1147270874.21536.66.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147273719.17886.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Wed, 10 May 2006 08:03:27 -0700
Message-Id: <1147273407.21536.88.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 16:08 +0100, Alan Cox wrote:
> On Mer, 2006-05-10 at 07:21 -0700, Daniel Walker wrote:
> > The writel on 1153 is attached to a memory leak, or I add one in this
> > patch ?
> 
> You exit without cleaning up.


Your talking about this warning ,

drivers/scsi/megaraid.c: In function ‘megadev_ioctl’:
drivers/scsi/megaraid.c:3665: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result


Ahh, I see .. I'll set rval as you suggested ..

Daniel

