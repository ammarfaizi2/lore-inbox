Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVDEV3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVDEV3C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVDEV2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:28:00 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:15030 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261925AbVDEVVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:21:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=l08vqcQsGQrZeyqPZ1RXDnltOq3ZOKpgU24EVo1eoBvVktOVfvIkGKcYvqzMyCyNhwN9tUsQcdMU6a9p/jY15I8z3NzxzRf6d1wvzJI8Clb0tY8g3nCJpQT4oZfZx2gyeR05zJgpDLnGAfT0d0zCLZw0LjxT3LNd2f6KU861Xjo=
Message-ID: <d120d50005040514215535d78f@mail.gmail.com>
Date: Tue, 5 Apr 2005 16:21:38 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jaco Kroon <jaco@kroon.co.za>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
Cc: Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       Sebastian Piechocki <sebekpi@poczta.onet.pl>
In-Reply-To: <4252FCA5.7040206@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <425166F9.1040800@kroon.co.za>
	 <d120d500050404110374fe9deb@mail.gmail.com>
	 <4251A515.8040802@kroon.co.za>
	 <d120d500050404140253a77ab8@mail.gmail.com>
	 <4251B6E2.3010506@kroon.co.za>
	 <d120d50005040415506cd87287@mail.gmail.com>
	 <4251D3CB.4010501@kroon.co.za> <4252D6F8.6000707@suse.de>
	 <d120d500050405113744837bd7@mail.gmail.com>
	 <4252FCA5.7040206@kroon.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 5, 2005 4:01 PM, Jaco Kroon <jaco@kroon.co.za> wrote:
> 
> btw Dmitri, that patch does not seem to work.  But the kernel panic that
> kicks in when X starts up does imply that _something_ changed.  No sync
> however, so no stack trace in the logs either.  In fact, looking at the
> dmesg part of those two boot attempts the serio i8042 driver doesn't
> even manage to find the KBD or AUX ports (No keyboard or mouse).
> 

I wounder how it could be. The patch just does i8042_nomux=1, exactly
as i8042.nomux does. Can I get that panic trace, please? I assume you
see it on the screen?

> I can do more trouble shooting at a later point.  For now I'll just use
> "i8042.nomux=1 usb-handoff" to boot with.  Thanks for the effort.

You were still using "usb-handoff" with my patch, weren't you? Only
"i8042.nomux" can be dropped.

-- 
Dmitry
