Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWBVWJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWBVWJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBVWJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:09:44 -0500
Received: from styx.suse.cz ([82.119.242.94]:8377 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751482AbWBVWJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:09:43 -0500
Date: Wed, 22 Feb 2006 23:09:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
Subject: Re: Suppressing softrepeat
Message-ID: <20060222220954.GA7930@suse.cz>
References: <20060221124308.5efd4889.zaitcev@redhat.com> <20060221210800.GA12102@suse.cz> <20060222120047.4fd9051e.zaitcev@redhat.com> <20060222204024.GA7477@suse.cz> <d120d5000602221309n58cad283q41a79e6fe013042d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000602221309n58cad283q41a79e6fe013042d@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 04:09:33PM -0500, Dmitry Torokhov wrote:
> > How about simply this patch instead?
> >
> > Setting autorepeat will not be possible on 'dumb' keyboards anymore by
> > default, but since these usually are special forms of hardware anyway,
> > like the DRAC3, this shouldn't be an issue for most users. Using
> > 'softrepeat' on these keyboards will restore the behavior for users that
> > need it.
> 
> I am not keen on changing the default behaviour... How many dumb
> keyboards are out there?

Apart from the DRAC3, some home-made Sun-to-PS2 converter, and a single
non-x86 embedded box, I don't recall anything. Answer: very few.

There may be users, though, that use this option to force the detection
of the keyboard when not really plugged in, eg. for flaky KVMs. I've
Googled for that usage, but found none.

> I'd rather turn atkbd.softrepeat into a 3-state switch...

We could, but the more I think about it, the stronger I'm convinced that
the dumbkbd => softrepeat => softraw option implication chain is wrong.
The second implication is necessary, but with dumbkbd it's quite likely
you won't want softraw.

-- 
Vojtech Pavlik
Director SuSE Labs
