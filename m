Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbVHTBWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbVHTBWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 21:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932794AbVHTBWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 21:22:37 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:13196 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932791AbVHTBWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 21:22:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VQm7dK46zI3+0YT1mVriiEvuWjXFpkSNpjVTY98KLH947baTGZ5jsT400KQvUGBNu6hxwWTtdOdwnnJIIj/hnyC9f7qJppLR4CqFLR0DGNooxqpITtz21eqj/BjWs3K/QR8ba+GXXMmuHgLcCn4Le2cZWX/iNTSpRdaEJYX4Y3I=
Message-ID: <9e473391050819182249e67dea@mail.gmail.com>
Date: Fri, 19 Aug 2005 21:22:30 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Daniel Phillips <phillips@istop.com>
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200508201050.51982.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508201050.51982.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Daniel Phillips <phillips@istop.com> wrote:
> Hi Joel,
> 
> Permissions set on ConfigFS attributes (aka files) do not stick.  The reason
> is that configfs attribute inodes are not pinned and simply disappear after
> each file operation.  This is good because it saves memory, but it is not
> good to throw the permissions away - you then don't have any way to expose
> configuration tweaks to normal users.  The patch below fixes this by copying
> each file's mode back into the non-transient backing structure on dentry
> delete.

A patch for making sysfs attributes persistent has recently made it
into Linus' tree.

http://article.gmane.org/gmane.linux.hotplug.devel/7927/match=sysfs+permissions

-- 
Jon Smirl
jonsmirl@gmail.com
