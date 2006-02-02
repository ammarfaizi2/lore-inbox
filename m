Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWBBQMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWBBQMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWBBQMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:12:14 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:59418 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932097AbWBBQMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:12:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gPsucsLVbDaQfZBbl5LXrfmg3/roZmCOYNBQ7gUBUyLhDY9MlTbAloOIBNbwqW4pNY80sGosMq4y1WHkrAtN+eb0XVqj4u+k/1odM3U/aNELga/VSxeb0T21Y9+YvpI7ncmUJRHP3DL/l/3ZPJ3uYUErQEb5GPIgLtLq4/bRJeg=
Message-ID: <d120d5000602020812j557164fdm6e1136eb04975be6@mail.gmail.com>
Date: Thu, 2 Feb 2006 11:12:11 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Shaun Jackman <sjackman@gmail.com>
Subject: Re: lsserio
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <7f45d9390602020800y1108a12ai832fd0b0ba630d24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390602020800y1108a12ai832fd0b0ba630d24@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Shaun Jackman <sjackman@gmail.com> wrote:
> Is there a lsserio utility, akin to lspci and lsusb? In particular,
> I'd like to see the result of the PS/2 GETID command for all PS/2
> buses and devices.
>

No there is no such utility because only some serio ports are PS/2.
You can try building serio_raw module and binding it to the port you
are interested in - it will provide you with something like old
/dev/psaux interface and will allow you to play with the device from
userspace.

--
Dmitry
