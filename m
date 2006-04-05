Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWDERGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWDERGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWDERGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:06:33 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:55570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751288AbWDERGd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:06:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UC80zqI/foh5C/s6qyBnEveQrJ3+YX44ZrWU+RjrOPdpEazOQKKse5C3p8Z5jAZDOFjU73SXumgj35ljbga/72ofREQSHxTfVfTjQCjSkbF472U3yUGQUeARN68I9Cb/ElxgbQcZJJeWdDhgT5QUI+0WGpnqAFuc0liRLfNE+uE=
Message-ID: <9e4733910604051006q447ec3absec038732c5a7a9f2@mail.gmail.com>
Date: Wed, 5 Apr 2006 13:06:32 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <20060405170226.GL27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060404235634.696852000@quad.kroah.org>
	 <20060404235947.GD27049@kroah.com>
	 <20060405190928.17b9ba6a.vsu@altlinux.ru>
	 <20060405152123.GH27946@ftp.linux.org.uk>
	 <9e4733910604050934s46ec20fbr905f78832431d91d@mail.gmail.com>
	 <20060405170226.GL27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Wed, Apr 05, 2006 at 12:34:49PM -0400, Jon Smirl wrote:
> > On 4/5/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> > > On Wed, Apr 05, 2006 at 07:09:28PM +0400, Sergey Vlasov wrote:
> > > > This will break the "color_map" sysfs file for framebuffers -
> > > > drivers/video/fbsysfs.c:store_cmap() expects to get exactly 4096 bytes
> > > > for a colormap with 256 entries.  In fact, the original patch which
> > > > changed PAGE_SIZE - 1 to PAGE_SIZE:
> > >
> > > ... cheerfully assuming that nobody assumes NUL-termination and
> > > everyone (sysfs patch writers!) certainly uses the length argument.
> > > Fscking brilliant, that.
> >
> > Why does sysfs have two string length determination methods - both
> > NULL termination and a length parameter. It should be one or the
> > other, not both. Having both simply cause problems when some
> > developers implement one scheme and others only implement the other.
>
> Which part of "sysfs patches can be written by idiots and usually are"
> is too hard to understand?  Oh, wait.  I see...  Well, nevermind, then...

I look forward to seeing your patches address these problems.

--
Jon Smirl
jonsmirl@gmail.com
