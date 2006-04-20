Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWDTNVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWDTNVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWDTNVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:21:47 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:50978 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750903AbWDTNVq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:21:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=rgTZK2EgVnpyp5RY9mPsQL9L5kimJY6VKka9MZOfdXziTDTr0kpn7gZDDi58xvxGvKo2owPUh+GEwP5t7N/ZunLUELQ4HkjL9NPuEdR0BnHrHfi1egE9YYrpG3hFqKt1lhGxHutlZknZHMxBeTgaeeowYBB8Hmn0rpmJm2bxRQ4=
Date: Thu, 20 Apr 2006 15:21:19 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-Id: <20060420152119.4de93d43.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	<20060419200001.fe2385f4.diegocg@gmail.com>
	<Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 19 Apr 2006 11:44:25 -0700 (PDT),
Linus Torvalds <torvalds@osdl.org> escribió:

> Anyway, when would you actually _use_ a kernel buffer? Normally you'd use 
> it it you want to copy things from one source into another, and you don't 

Thanks,I wonder it splice can be useful for more cases than just high-bandwith
blind transference of data? For example, in X.org as of today, I think that
pixmaps need to be copied from the client adress space to the server. Because
X.org is network-oriented the pixmaps must be sent even in local machines,
(in order to save memory when clients move a pixmap to the server they must 
free it in their address space, because extra copies mean high memory usage,
at some point nautilus was keeping three copies of the desktop background
in memory)

There're shared memory extensions in commercial X servers which I think
they fix this for local usage (there're rumors that Sun may port and
contribute their Xsun shared memory implementation to x.org in the
future), but I wonder if splice could be an alternative aswell? Or
maybe splice is not a good option when you need several MB? (if the buffer
size becomes tweakable in the future)
