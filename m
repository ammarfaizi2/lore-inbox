Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUDXH1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUDXH1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 03:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUDXH1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 03:27:42 -0400
Received: from zasran.com ([198.144.206.234]:17024 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S262020AbUDXH1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 03:27:40 -0400
Message-ID: <408A16EB.30208@bigfoot.com>
Date: Sat, 24 Apr 2004 00:27:39 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
References: <40853060.2060508@bigfoot.com> <200404202326.24409.kim@holviala.com>
In-Reply-To: <200404202326.24409.kim@holviala.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala wrote:
> On Tuesday 20 April 2004 17:14, Erik Steffl wrote:
> 
> 
>>   it looks that after update to 2.6.5 kernel (debian source package but
>>I guess it would be the same with stock 2.6.5) the mouse wheel and side
>>button on Logitech Cordless MouseMan Wheel mouse do not work.
> 
> 
> Try my patch for 2.6.5: http://lkml.org/lkml/2004/4/20/10
> 
> Build psmouse into a module (for easier testing) and insert it with the proto 
> parameter. I'd say "modprobe psmouse proto=exps" works for you, but you might 
> want to try imps and ps2pp too. The reason I wrote the patch in the first 
> place was that a lot of PS/2 Logitech mice refused to work (and yes, exps 
> works for me and others)....

   didn't help, I still see (without X running):

8, 0, 0 any button down
9, 0, 0 left button up
12, 0, 0 wheel up, sidebutton up
10, 0, 0 right button up

8, 0, 0 wheel rotation (any direction)

except of some protocols (IIRC ps2pp, bare, genps) ignore wheel 
completely. is there any way to verify which protocol the mouse is 
using? modprobe -v printed different messages for each protocol so I 
think that worked (it said Generic Explorer etc.)

   I tried: exps, imps, ps2pp, bare, genps

   any ideas?

   the mouse says: Cordless MouseMan Wheel (Logitech), it has left/right 
buttonss, wheel that can be pushed or rotated and a side button, not 
sure how to better identify it. With 2.4 kernels it used to work with X 
using protocol MouseManPlusPS/2.

	erik
