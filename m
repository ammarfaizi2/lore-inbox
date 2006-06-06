Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWFFTpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWFFTpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 15:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWFFTpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 15:45:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:1505 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751021AbWFFTpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 15:45:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Qc+li9RNLuDfiggQDhl8WnR/E0OzsdDT/1dOyoBmtMcSLYIWaaj2dnuCNRgDyctnb35Iw9/6A/TMerFbR92R1FaH83HAjTU/uWNSiXmHcxpczjQqs4pHExSjmDECFuHtriE51BUDFKhZX52XZOt1QcCtHlXOgmn30K7go7XyCDY=
Message-ID: <4485DB56.7020004@gmail.com>
Date: Wed, 07 Jun 2006 03:45:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Detaching fbcon
References: <44856223.9010606@gmail.com> <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
In-Reply-To: <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Overall, this feature is a great help for developers working in the
>> framebuffer or console layer.  There is not need to continually reboot
>> the
>> kernel for every small change. It is also useful for regular users who
>> wants
>> to choose between a graphical console or a text console without having to
>> reboot.
> 
> Instead of the sysfs attribute, what about creating a new escape
> sequence that you send to the console system to detach? Doing it that
> way would make more sense from a stacking order. It just seems
> backwards to me that you ask a lower layer to detach from the layer
> above it.

It is not the vt layer that attaches fbcon, it's fbcon that attaches
to the vt layer. So it is more logical that fbcon detaches itself, not
the other way around.
 
Tony
