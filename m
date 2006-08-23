Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWHWLgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWHWLgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWHWLgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:36:06 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:46689 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932407AbWHWLgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:36:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fuLVuU8j2K2iM1E36Qyf1f8Xhvr7ApICsqNivw/XY7xkQnMaa9XIif04sXE3kS/zhfllPyEr4ifH+WGwnhyrThz8fbkPG/djGogXCwNKmJAUVYxx0uGq/Rib+ztXdh5xmH+IuFbuQ+DjfIFDdKbzEhk3yDBrZhTV6DFEHgUvOmc=
Message-ID: <2c0942db0608230435n1b680f11q3b19669f0bb62268@mail.gmail.com>
Date: Wed, 23 Aug 2006 04:35:59 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Robert Szentmihalyi" <robert.szentmihalyi@gmx.de>
Subject: Re: Group limit for NFS exported file systems
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060823111119.203710@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060823091652.235230@gmx.net>
	 <2c0942db0608230355s74af2717g78675ea56b689fc0@mail.gmail.com>
	 <20060823111119.203710@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Robert Szentmihalyi <robert.szentmihalyi@gmx.de> wrote:
> > Is he a member of more than 16 groups?
>
> Yes. He is actually a member of 27 groups.
> Is the limit of 16 groups still current? I was under the impression that it is a limitation of 2.4 kernels....

Under 2.6 local group membership was expanded to 65536. NFS, however,
is a standard separate from Linux, and it imposes a limit of 16 groups
on the wire for the AUTH_UNIX credentials.

If all your client systems are Linux, you can use the patch at:
    http://www.frankvm.com/nfs-ngroups/
as a work around. (Only the client systems need the patch.)

I haven't used it myself, so best of luck.

Ray
