Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUDTWfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUDTWfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbUDTWeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:34:17 -0400
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:26245 "EHLO
	home.holviala.com") by vger.kernel.org with ESMTP id S264428AbUDTU0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 16:26:15 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
Date: Tue, 20 Apr 2004 23:26:24 +0300
User-Agent: KMail/1.6.1
References: <40853060.2060508@bigfoot.com>
In-Reply-To: <40853060.2060508@bigfoot.com>
Cc: Erik Steffl <steffl@bigfoot.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404202326.24409.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 17:14, Erik Steffl wrote:

>    it looks that after update to 2.6.5 kernel (debian source package but
> I guess it would be the same with stock 2.6.5) the mouse wheel and side
> button on Logitech Cordless MouseMan Wheel mouse do not work.

Try my patch for 2.6.5: http://lkml.org/lkml/2004/4/20/10

Build psmouse into a module (for easier testing) and insert it with the proto 
parameter. I'd say "modprobe psmouse proto=exps" works for you, but you might 
want to try imps and ps2pp too. The reason I wrote the patch in the first 
place was that a lot of PS/2 Logitech mice refused to work (and yes, exps 
works for me and others)....



Kim

