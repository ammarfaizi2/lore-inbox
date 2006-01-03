Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWACTf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWACTf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWACTf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:35:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22409 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932498AbWACTf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:35:56 -0500
Date: Tue, 3 Jan 2006 11:35:33 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb: replace __setup("nousb") with __module_param_call
Message-Id: <20060103113533.6ac3e351.zaitcev@redhat.com>
In-Reply-To: <d120d5000601030646u4dfe2951ka26586050cac5f0b@mail.gmail.com>
References: <20051220141504.31441a41.zaitcev@redhat.com>
	<200512220110.52466.dtor_core@ameritech.net>
	<20051222002423.1791d38b.zaitcev@redhat.com>
	<200601030147.46504.dtor_core@ameritech.net>
	<20060102230714.3aa4f85b.zaitcev@redhat.com>
	<d120d5000601030646u4dfe2951ka26586050cac5f0b@mail.gmail.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006 09:46:26 -0500, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > But even if it does, my patch saved reading, so I think it should be
> > applied as well.
> 
> What you mean by "saved reading"?

The diffstat was almost all dashes: 13 deletions, 1 addition.

> Btw, do we really need to export "nousb" in sysfs?

Nobody would die if we didn't, but there's nothing wrong with the idea
in general. At least you'd know that the parameter was actually parsed.
I wish usb-handoff was exported similarly, because there's absolutely
no way to tell if it worked or was quietly ignored. And I abhor printks
in normal or success cases, so I do not want such indication.

-- Pete
