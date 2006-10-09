Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbWJIOKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWJIOKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbWJIOKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:10:51 -0400
Received: from mx2.rowland.org ([192.131.102.7]:38928 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S932715AbWJIOKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:10:50 -0400
Date: Mon, 9 Oct 2006 10:10:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Jaroslav Kysela <perex@suse.cz>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>,
       Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] Driver core: Don't ignore bus_attach_device() retval
In-Reply-To: <20061009131434.6e3ff0e2@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610091010030.30076-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006, Cornelia Huck wrote:

> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Check for return value of bus_attach_device() in device_add(). Add a
> function bus_delete_device() that undos the effects of bus_add_device().
> bus_remove_device() now undos the effects of bus_attach_device() only.
> device_del() now calls bus_remove_device(), kobject_uevent(),
> bus_delete_device() which makes it symmetric to the call sequence in
> device_add().
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

This looks good to me.

Alan Stern

