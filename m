Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUDTWYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUDTWYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUDTWW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:22:56 -0400
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:28037 "EHLO
	home.holviala.com") by vger.kernel.org with ESMTP id S264499AbUDTUio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 16:38:44 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse fixes for 2.6.5
Date: Tue, 20 Apr 2004 23:38:53 +0300
User-Agent: KMail/1.6.1
References: <200404201038.46644.kim@holviala.com> <200404200759.11446.dtor_core@ameritech.net>
In-Reply-To: <200404200759.11446.dtor_core@ameritech.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404202338.53773.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 15:59, Dmitry Torokhov wrote:
> On Tuesday 20 April 2004 02:38 am, Kim Holviala wrote:
> > Some fixes for PS/2 mice:
> >
> > - fixed hotplugging (real reset of device instead of softreset)
> > - support for Targus Scroller mice (from my last weeks patch)
> > - extended protocol probing fixed
>
> Why do you have Tragus as a config option - just set the protocol mask
> correctly by default...

Targus mice misuse the normal PS/2 protocol so that they can sneak through 
command-filtering PS/2 ports (like on my Digital HiNote 2000). Basically they 
output very strange but valid traffic when the wheel is moved. Anyway, this 
is Linux, and I'd rather force people to turn it on explicitly rather than 
take the risk of breaking some valid PS/2 device which might theoretically 
output the same stuff.




Kim


