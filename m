Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTLYShF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 13:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTLYShF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 13:37:05 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:63904 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S264356AbTLYShD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 13:37:03 -0500
Date: Thu, 25 Dec 2003 19:22:38 +0100
From: GCS <gcs@lsc.hu>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: 2.6.0-mm1
Message-ID: <20031225182238.GA32439@lsc.hu>
References: <20031224095921.GA8147@lsc.hu> <20031224033200.0763f2a2.akpm@osdl.org> <200312250411.55881.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200312250411.55881.dtor_core@ameritech.net>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 04:11:54AM -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> I am sending 2 patches - one to remove mouse jitter with Synaptics when
> it is used through mousedev (PS/2 emulation) - mousedev will use 3 point
> history and average when calculating deltas, the other one is the fix for
> the problem you are experiencing. They should apply to 2.6.0-mm1 and to
> stock 2.6.0 with minimal jitter.
 I have applied both to 2.6.0-mm1. They are just working, no jumping
mouse pointer when I release the touchpad, and both touchpad+usb mouse
working on console and under XFree86 as well. OK, I could not really
understand how they are working, as for me it seems gpm interprets
/dev/psaux only, and get both pointing device right, still XFree86 which
reads data replicated by gpm via gpmdata can't handle the USB mouse
directly. I had to use a separate config, which reads /dev/input/mice as
well. I think it's because XFree86's synaptics driver skip events from
the USB mouse. Anyway, thanks for your help and work!

Merry Christmas!
GCS
-- 
BorsodChem Joint-Stock Company				Linux Support Center
Software engineer					Developer
+36-48-511211/12-99                                     +36-20-4441745
