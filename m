Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbTFLSo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264947AbTFLSo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:44:57 -0400
Received: from maild.telia.com ([194.22.190.101]:22761 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S264946AbTFLSoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:44:55 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz>
	<m27k7sv5si.fsf@telia.com> <20030611203408.A6961@ucw.cz>
	<m2ptlkqpej.fsf@telia.com> <20030612024814.GB4787@rivenstone.net>
	<20030612025442.GA566@zip.com.au>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Jun 2003 20:58:17 +0200
In-Reply-To: <20030612025442.GA566@zip.com.au>
Message-ID: <m27k7rnmwm.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> writes:

> On Wed, Jun 11, 2003 at 10:48:14PM -0400, Joseph Fannin wrote:
> > > Here is a new patch that sends ABS_ events to user space. I haven't
> > > modified the XFree86 driver to handle this format yet, but I used
> > > /dev/input/event* to verify that the driver generates correct data.
> > 
> >     How well will GPM (for example) work with this?
> 
> Aaaand... will I be able to transparently use my ps2 mouse and touchpad
> without having to worry about what's plugged in at any one time?

It works on my computer at least. When loading the psmouse module I
get this:

        input: PS/2 Logitech Mouse on isa0060/serio2
        Synaptics Touchpad, model: 1
         Firware: 5.6
         180 degree mounted touchpad
         Sensor: 18
         new absolute packet format
         Touchpad has extended capability bits
         -> four buttons
         -> multifinger detection
         -> palm detection
        input: Synaptics Synaptics TouchPad on isa0060/serio4

The touchpad and the mouse operates independently of each other. The
mouse generates relative events as usual and the touchpad generates
absolute events as defined by my previous patch.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
