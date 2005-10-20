Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVJTXDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVJTXDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVJTXDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:03:09 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:51683 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964778AbVJTXDH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:03:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NTQ20Xib7UPqE3zE6K1D1g7Zlu2tMJ1ZRIbzfS/5JBJGXEkasrRnw3sFQGQKhyzgxWpfRrm+YKlSCU8yHIWc4W4LY7peqRGC4uyEeoQ5TUFA0yXRyAI13j2horup6k+fJcLeA02ecgUXGKENd5qhIGqhpWcLXteQH2Gf8EJIHCg=
Message-ID: <d120d5000510201603n50c068dcyade2ce2cfd2311e0@mail.gmail.com>
Date: Thu, 20 Oct 2005 18:03:06 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jonathan Mayer <jonmayer@google.com>
Subject: Re: [PATCH] added sysdev attribute to sysdev show/store methods - for linux-2.6.13.4
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4a45da430510201503v74874acoca37bba3aa5a2d07@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com>
	 <d120d5000510201459y25a2c8e5v55bf830c445c9dbf@mail.gmail.com>
	 <4a45da430510201503v74874acoca37bba3aa5a2d07@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/05, Jonathan Mayer <jonmayer@google.com> wrote:
> Surely, the organization of sysfs is logical (by grouping relating
> things) rather than functional (by grouping things that need common
> back-end interfaces).
>
> Er .. no?
>
> In general, where can I find guidance on where to put things within
> sysfs?  Has anybody written some kind of Plan?
>

If it is a device it goes onto corresponding bus. Platform bus is a
kind of a kitchen sink for things that do not have a "real" bus -
things like keyboard controller, older ISA devices, etc. Only things
that necessary to get the box going and have to be suspended last with
interrupts off (like IRQ controller) should be implemented as system
devices.

--
Dmitry
