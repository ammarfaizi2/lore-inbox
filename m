Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVARP75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVARP75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVARP62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:58:28 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:27121 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261335AbVARP4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:56:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=F516zMD5p1uYhEHNRfSGgW+m3TunQ3JvUMPQ+9UWE41Cva1Nkfvu/MGx8jl2xgg4RzH7WdBzJZksBxi6XiOAs4h2U9srQjOjV1iQuVj7gc2im38jA/0iF0oPFSv7qDSPCD9iVou/Yutwr66chyBL2JVY0J4E0sB/TPClIeu8ung=
Message-ID: <d120d50005011807566ee35b2b@mail.gmail.com>
Date: Tue, 18 Jan 2005 10:56:40 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] Remove input_call_hotplug
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <41ED2457.1030109@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ED2457.1030109@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Jan 2005 15:59:35 +0100, Hannes Reinecke <hare@suse.de> wrote:
> Implement proper class names for input drivers.
> 

This patch probably should probably use atomic_inc in case we ever
have non-serialized probe functions.

But the real question is whether we really need class devices have
unique names or we could do with inputX thus leaving individual
drivers intact and only modifying the input core. As far as I
understand userspace should be concerned only with device
capabilities, not particular name, besides, it gets PRODUCT string
which has all needed data encoded.

What do you think?

-- 
Dmitry
