Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbTCFVS3>; Thu, 6 Mar 2003 16:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268384AbTCFVS3>; Thu, 6 Mar 2003 16:18:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17576
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268377AbTCFVS2>; Thu, 6 Mar 2003 16:18:28 -0500
Subject: Re: Make ipconfig.c work as a loadable module.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robin Holt <holt@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com>
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046990052.18158.121.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 22:34:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 21:10, Robin Holt wrote:
> The patch at the end of this email makes ipconfig.c work as a loadable 
> module under the 2.5.  The diff was taken against the bitkeeper tree 
> changeset 1.1075.

The right fix is to delete ipconfig.c, it has been the right fix for a long
long time. There are initrd based bootp/dhcp setups that can also then mount
a root NFS partition and they do *not* need any kernel helper.

Indeed probably the biggest distro using nfs root (LTSP) doesn't use ipconfig
even on 2.4. 

DaveM can you just remove the thing. See http://www.ltsp.org for initrds that
don't need it in
