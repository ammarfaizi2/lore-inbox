Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752438AbWJ0UD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbWJ0UD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbWJ0UD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:03:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:47372 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752438AbWJ0UD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:03:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r74MvDsjEWw3/iJocRytaroIlxl9yL3/S0DZkqdXYNdKBKGBan9fInRJUo95BlQmQ++qRKtyqZNUihO55v3Js2p8vf0ccGzeAmXT+4wxruO6IKQm4cjJCLcGlx2brrllqgM9gX8IJeKSa8CrctK9OInDRgLQfT3gFBa4dvBefF4=
Message-ID: <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>
Date: Fri, 27 Oct 2006 22:03:25 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE85B.2080702@innova-card.com>
	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> To be clearer. And you are wrong: you can write other modules which
> want to know what the LCD is showing, or use it; without worrying
> about framebuffer things. They can read / write "cfag12864b_buffer" as
> well as cfag12864bfb do. Why not?
>

Suppose I'm writing a user space application which uses your frame
buffer driver. I would naturaly mmap your device since it's the
easiest way to use a frame buffer. Now I want to display as fast as
possible a set of images. How am I sure that each image is sent to the
lcd ? For example, suppose the application just finished to copy image
A into the buffer,  and now it starts to copy image B into the buffer
but the work queue has not been scheduled yet...

Futhermore I'm not sure it's a common use case for such device, is it
? I would say that the usual case for such LCD is to display an image
every now and then. If so do we really need to give the possibility to
mmap the device ? Is a simple synchrone write() enough ?

BTW how can the application retrieve the refresh rate from the driver ?

                Franck
