Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWFHIyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWFHIyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWFHIyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:54:35 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:1866 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751296AbWFHIye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:54:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=j0Ap+9HrGHgPY0//97hircxEcqEV2P4gA5wk6K4hiqpaWfWQJ/xlfUQOvVRlmHpa8F23tlX9O8iMTV3CNGG7XPRcrfw+55hdRva9b8pWbGGwtDf9x/DGAIf0elfjhoCuxQpJQngFVGT26ZkNV93K2T1DMRAOXzTrqK/Ek4TbQeg=
Message-ID: <4487E034.8010808@gmail.com>
Date: Thu, 08 Jun 2006 16:30:44 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Daniel Hazelton <dhazelton@enter.net>
CC: Helge Hafting <helge.hafting@aitel.hist.no>,
       Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Ondrej Zajicek <santiago@mail.cz>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com> <4487CB77.3050503@aitel.hist.no> <200606080341.00382.dhazelton@enter.net>
In-Reply-To: <200606080341.00382.dhazelton@enter.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Hazelton wrote:
> On Thursday 08 June 2006 03:02 am, Helge Hafting wrote:
>> Jon Smirl wrote:
>>> On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
> Okay. I'll stick this on my list. Shouldn't be too hard to get to, provided I 
> can finish up my work on drmcon. (Tony, I'm still waiting on that unloadable 
> fbcon/fbdev bit and the userspace fbdev driver you mentioned)

I already have a preliminary patch that allows the binding and unbinding
of fbcon which I sent to lkml and fbdev-devel.  Jon and Andrew are against
having the control in fbcon, so I'm  currently working on another patch that
will transfer the control to the console layer.  It was a bit more complicated
that what I thought, but I'm almost done. I'm just in  debugging mode, and so
far I haven't encountered any major problems.

The nice thing about this change is that it's not restricted to fbcon. Other
console drivers can explicitly bind or unbind, ie, your future drmcon.

I may send out the patch within a day or 2. After this, I'll start work on
the userland driver.

Tony

