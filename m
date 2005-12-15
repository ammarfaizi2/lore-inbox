Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVLOBZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVLOBZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVLOBZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:25:51 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:63544 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932441AbVLOBZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:25:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LlRT+KkJrz9XyyN2hG1hjTKX3oHkNZVT26vhsOZtwOoqKB0pbOsBWfeEmo00xgkWYK0DQ8Jtp64NGeNlpiyJPbD2mBOYmfGQqZ1Uqn1xQGqYLI9pp954oQT+1oygpr3MQFDvSW4op0doCLJ9zK+a6wKh29QsiZYesBeIIpYaPbY=
From: Kurt Wall <kwallinator@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Console Goes Blank When Booting 2.6.15-rc5
Date: Wed, 14 Dec 2005 20:27:00 -0500
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200512132247.54341.kwallinator@gmail.com> <439FBDC5.5060609@gmail.com>
In-Reply-To: <439FBDC5.5060609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512142027.00829.kwallinator@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 December 2005 01:37 am, Antonino A. Daplas wrote:
> Kurt Wall wrote:
> > As Jesper Juhl has reported, if I boot 2.6.15-rc5 with vga=normal,
> > everything is fine. If I boot using my preferred size (vga=794),
> > the console goes blank. Because I'm a touch typist, I can login and
> > start X and everything is copacetic, but as soon as I leave X, I'm
> > back to the blank screen. From X, if I flip over to a VC, the VC
> > display is garbled and has artifacts from the X display.
> >
> > This worked fine with 2.6.14.3, and I didn't change the console,
> > framebuffer, or vesa options between the two kernels. Not sure how
> > to proceed, but I sure would like my high res console screens back.
>
> Can you recheck your .config and make sure that
> CONFIG_FRAMEBUFFER_CONSOLE=y

Oops. It was defined as a module. Compiling it statically gave me
the console back. Interestingly, I still lose the first 102 lines
of console output. After the all-important boot logo displays, I see
nothing until this line:

"Console: switching to colour frame buffer device 160x64"

It's all there in the ring buffer, of course. Thanks, Antonino.

Kurt
-- 
The mosquito is the state bird of New Jersey.
  -- Andy Warhol
