Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWBVVQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWBVVQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBVVQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:16:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17054 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750817AbWBVVQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:16:40 -0500
Date: Wed, 22 Feb 2006 13:16:13 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com, zaitcev@redhat.com
Subject: Re: Suppressing softrepeat
Message-Id: <20060222131613.2b6cc64c.zaitcev@redhat.com>
In-Reply-To: <20060222204024.GA7477@suse.cz>
References: <20060221124308.5efd4889.zaitcev@redhat.com>
	<20060221210800.GA12102@suse.cz>
	<20060222120047.4fd9051e.zaitcev@redhat.com>
	<20060222204024.GA7477@suse.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006 21:40:24 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:

> Setting autorepeat will not be possible on 'dumb' keyboards anymore by
> default, but since these usually are special forms of hardware anyway,
> like the DRAC3, this shouldn't be an issue for most users. Using
> 'softrepeat' on these keyboards will restore the behavior for users that
> need it.

> +++ b/drivers/input/keyboard/atkbd.c
> @@ -863,9 +863,6 @@ static int atkbd_connect(struct serio *s
>  	atkbd->softrepeat = atkbd_softrepeat;
>  	atkbd->scroll = atkbd_scroll;
>  
> -	if (!atkbd->write)
> -		atkbd->softrepeat = 1;
> -

This looks good to me, because it makes the operation of the code more
straightforward and easier to understand. With our docs always lagging,
it's important.

Like you said, it does "punish" people who had "dumb" keyboards, but if
they really are a special class of folks, maybe it's better that way.

And I think it's much easier to type a command to enable softrepeat
than to type a command to disable softrepeat when all your letters come
in twos and threes :-)

-- Pete
