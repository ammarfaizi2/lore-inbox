Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWJILJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWJILJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbWJILJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:09:43 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:46516 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751803AbWJILJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:09:42 -0400
Date: Mon, 9 Oct 2006 13:10:12 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jaroslav Kysela <perex@suse.cz>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>
Subject: Re: [Alsa-devel] [PATCH] Driver core: Don't ignore error returns
 from probing
Message-ID: <20061009131012.3ba21242@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610061400180.1311-100000@netrider.rowland.org>
References: <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610061400180.1311-100000@netrider.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 14:12:49 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> I'm still not sure why bus_attach_device() was split off from 
> bus_add_device() in the first place.  Was it just so that the 
> kobject_uevent() call could go in between?

I think yes. This was added in
http://marc.theaimsgroup.com/?l=linux-kernel&m=115092084915731&w=2

> This looks okay, but it would be better if bus_remove_device() did not
> directly call bus_delete_device().  Just add an extra call inside
> device_del(), so that everything remains symmetrical.
> 
> While I'm harping on style issues, you should also capitalize AttachError
> so that it matches the form of the other statement labels nearby.  And in
> bus_remove_device() you should put all the code inside the "if" block
> instead of returning when dev->bus isn't set, just as the neighboring
> subroutines do.

OK, new patch on the way.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
