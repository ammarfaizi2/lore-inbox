Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbUK0BoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUK0BoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbUKZTiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:38:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262369AbUKZTV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:21:56 -0500
To: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 34/51: Includes
In-Reply-To: <1101327443.3425.11.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101297843.5805.324.camel@desktop.cunninghams> <20041124132558.GB13034@infradead.org> <20041124132558.GB13034@infradead.org> <1101327443.3425.11.camel@desktop.cunninghams>
Date: Wed, 24 Nov 2004 23:19:09 +0000
Message-Id: <E1CX6Pl-0002Gg-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> I can see that it might look that way, but it's actually fundamental to
> the support for building as modules (which is required for LVM &
> encryption), and has been really helpful in creating clear distinctions
> between the different parts of suspend. It also provides a clear method
> for someone to add support for their new wizz-bang storage method or
> compressor.

I'm not entirely clear on this. Surely all that's needed for LVM and
encryption support is for that to be set up in userspace and then allow
userspace to trigger a second attempt at resume? I have a hacky patch
for swsusp that allows that (at the moment it just adds a "resume"
method to /sys/power/state), which gives you the functionality without
the module pain.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
