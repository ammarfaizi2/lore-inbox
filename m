Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVCBRRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVCBRRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVCBRPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:15:04 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:50804 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262341AbVCBRM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:12:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UPTU7dDvyfsmQbEVr3LQntOADKA9B52gnOzqAaBNvzoZkmCczrZ8hhCJ7Ez7X10Sdb4abKuNAtEB5/RIN8n92aKDCzm/S+7GJ5PIUui65goPhvMAfCuBQjoZyZmlQsWnYvMpz3LwoocIImu28vKHA2JoXHaEJTEVK+i2aAU3FWM=
Message-ID: <d120d50005030209123b8db1ae@mail.gmail.com>
Date: Wed, 2 Mar 2005 12:12:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "MIGUELANXO@telefonica.net" <MIGUELANXO@telefonica.net>
Subject: Re: 2.6.11: touchpad unresponsive
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3d668208.82083d66@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3d668208.82083d66@teleline.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 16:55:59 +0100, MIGUELANXO@telefonica.net
<MIGUELANXO@telefonica.net> wrote:
> I just compiled 2.6.11 from 2.6.10 config using 'make oldconfig',
> activate new options to default values (i.e. set "main kernel lock
> preemtive" to YES).
> 
> Booting X in new kernel makes my touchpad very unresponsive. I can't
> click any longer in the touchpad area, and the touchpad doesn't response
> when moving in small increments, so the whole experience is quite bad.
> 

If it is identified as an ALPS touchpad you can try installing Peter
Osterlund's Synaptics X driver:

           http://web.telia.com/~u89404340/touchpad/

Alternatively you can restore 2.6.10 behavior with psmouse.proto=exps
boot option (if psmouse is a module add "options psmouse proto=exps"
to your /etc/modprobe.conf).

-- 
Dmitry
