Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbSJ0PDY>; Sun, 27 Oct 2002 10:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSJ0PDY>; Sun, 27 Oct 2002 10:03:24 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:5138 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262424AbSJ0PDY>; Sun, 27 Oct 2002 10:03:24 -0500
Date: Sun, 27 Oct 2002 15:09:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andreas Haumer <andreas@xss.co.at>, linux-kernel@vger.kernel.org,
       willy@w.ods.org
Subject: Re: rootfs exposure in /proc/mounts
Message-ID: <20021027150936.A20310@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Andreas Haumer <andreas@xss.co.at>,
	linux-kernel@vger.kernel.org, willy@w.ods.org
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com> <3DBBBE1B.5050809@xss.co.at> <3DBC0007.8020005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBC0007.8020005@pobox.com>; from jgarzik@pobox.com on Sun, Oct 27, 2002 at 10:02:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 10:02:31AM -0500, Jeff Garzik wrote:
> symlinks directly to /proc/mounts is fine with me -- just don't expect 
> any sympathy when userspace tools don't handle things like $subject.  :) 
>  The answer will be "fix the userspace tools" not "add special case code 
> to the kernel" :)

well, better link to /proc/self/mounts directly, that's where /proc/mounts
links to.  That's another reason why the /etc/mtab-concept is broken:
you might have very different mounts in different processes.

