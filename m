Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVHTGUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVHTGUI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 02:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVHTGUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 02:20:08 -0400
Received: from smtp.istop.com ([66.11.167.126]:21653 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751079AbVHTGUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 02:20:07 -0400
From: Daniel Phillips <phillips@istop.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Date: Sat, 20 Aug 2005 16:21:01 +1000
User-Agent: KMail/1.7.2
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
References: <200508201050.51982.phillips@istop.com> <9e473391050819182249e67dea@mail.gmail.com>
In-Reply-To: <9e473391050819182249e67dea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508201621.02151.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 August 2005 11:22, Jon Smirl wrote:
> A patch for making sysfs attributes persistent has recently made it
> into Linus' tree.
>
> 
http://article.gmane.org/gmane.linux.hotplug.devel/7927/match=sysfs+permissions

Interesting, it handles more than just the file mode.  But does anybody really 
care about the ctime/atime/mtime in sysfs?  I can see how uid and gid could 
be useful.  My way of handling this (by copying out the potentially changed 
iattrs when the dentry is destroyed) looks more compact than Maneesh's 
solution, while not being any less effective, once I get it right that is.  
Does sysfs really need its own setattr?

A quibble: we normally use the term persistent to mean "saved on permanent 
storage".  Going by that, Maneesh just fixed a bug and did not make iattrs 
persistent.

Regards,

Daniel
